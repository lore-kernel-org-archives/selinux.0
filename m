Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA9EYPTJ020032
	for <selinux@tycho.nsa.gov>; Thu, 9 Nov 2006 09:34:25 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id kA9EWnin004156
	for <selinux@tycho.nsa.gov>; Thu, 9 Nov 2006 14:32:49 GMT
Message-ID: <45533C71.3080802@tresys.com>
Date: Thu, 09 Nov 2006 09:34:25 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: I would like to propose that we add compression to handle all
 policy files on disk.
References: <45533208.6050806@redhat.com>
In-Reply-To: <45533208.6050806@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> We are currently storing three sets of pp files on disk in Fedora as 
> well as a policy.21 file
3 policy.21 files (deceptively named policy.kern in the module store...) 
plus 2 fully linked copies (base.linked) which is essentially a copy of 
all the policy packages concatenated (which is much larger than the 
policy.21 file)

As of right now base.linked is unused, we had some plans to eventually 
use it for 1) verification of the policy via external tools (libsemanage 
already supports this but noone is using it) and 2) a while back I 
suggested we could do incremental linking to speed up the process.

Getting rid of it almost halves the store size alone:

[root@poisonivy targeted]# du -sh modules/
38M     modules/
[root@poisonivy targeted]# rm modules/*/base.linked
[root@poisonivy targeted]# du -sh modules/        
21M     modules/

> To get an idea of how much space we can save, I did this little 
> experiment.    I believe this change is
> critical for minimal installs, and if we want to eventually use 
> SELinux on certain small platforms.
>
> I think just changing libsemanage to handle compressed policy packages 
> and to create its itermediary files as compressed files and changing 
> libselinux able to read a compressed policy.21 file.
>
libsepol does all the reading and writing, if we were to support 
compressed policies it would have to be there, not in libsemanage.

> # tar cvf /tmp/selinux /etc/selinux/targeted /usr/share/selinux/targeted/
there are files in here that we probably wouldn't want to compress like 
contexts/*, conf files, etc. (granted they are very small compared to 
policy packages and kernel policy..
> # gzip -c /tmp/selinux > /tm/selinux.gz
>
> # du /tmp/selinux*
> 57380   /tmp/selinux
> 3772    /tmp/selinux.gz

I wouldn't be adverse to someone adding a libsemanage option to not save 
the previous directory on success, we don't actually provide a revert 
interface as of now (though we probably should if we are going to keep 
it around..)

[root@poisonivy targeted]# rm -rf modules/previous/
[root@poisonivy targeted]# du -sh modules/
11M     modules/

(this was after the base.linked getting deleted above, add 9 meg to this 
if we keep that around..)

so there we've cut the module directory by 1/4 potentially, just how 
much space are we needing to save?

The main concern I have with this is that libz hasn't had an awesome 
security record and it would have to be used by the component of the 
toolchain closest to the kernel, load_policy.

Additionally, on Fedora libz is in /usr/lib which means init won't be 
able to use it to decompress the policy at boot time, I really don't 
think we should be pulling a static libz into libselinux and libsepol.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1H0JqKW018340
	for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2009 19:19:52 -0500
Received: from rv-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1H0GV4l025550
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 00:16:31 GMT
Received: by rv-out-0708.google.com with SMTP id f25so2116458rvb.54
        for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2009 16:19:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <200902170935.19429.russell@coker.com.au>
References: <dd18b0c30902142013u323f4853v34270dd2c5e21132@mail.gmail.com>
	 <dd18b0c30902152208r46e439e5r6bcabfc299bc2ac8@mail.gmail.com>
	 <dd18b0c30902160618p5501ecdaie3ffefd96b66188a@mail.gmail.com>
	 <200902170935.19429.russell@coker.com.au>
Date: Mon, 16 Feb 2009 16:19:50 -0800
Message-ID: <dd18b0c30902161619m3ffced46t8a90cceadf76b255@mail.gmail.com>
Subject: Re: sysvinit doesnt see libselinux/libsepol (LFS system);
From: Justin Mattock <justinmattock@gmail.com>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Feb 16, 2009 at 2:35 PM, Russell Coker <russell@coker.com.au> wrote:
> On Tue, 17 Feb 2009, Justin Mattock <justinmattock@gmail.com> wrote:
>> The issue I have is using dpkg/or apt-get already has the right
>> patch applied and init already compiled in, in accordance to the distro.
>
> If you take the original source plus the Debian patch and use it in place of
> the original source for your LFS build then it should be fine.
>

I took the original source from the debian sid site + 40_selinux.patch
and saw no signs of loading a policy.
heres the location of the patch:
http://patch-tracking.debian.net/package/sysvinit/2.86.ds1-61
maybe I should add some more patches besides 40_selinux.

>> doing a (LFS) tutorial, under the documentation
>> has me building everything from the source.
>> (a lot of work, but worth the learning experience);
>
> It's also a learning experience to contribute to the integration of SE Linux
> in a major distribution such as Debian, Gentoo, or Fedora.  I think that in
> the long run there would be more benefits to both you personally and the
> community if you were to contribute to one of these projects.  I suggest that
> you choose Debian, but I admit to being biased in this regard.  ;)
>

Well I did a debootstrap installation a few days ago, but then
said to myself how do I do all the stuff that debootstrap does.
then one thing led to the next, weeks later and here I am.
as a side note:
one of the main goals right
(as a test) is to see what happens to the system when one
atomically sync's all the libs/apps to the processor using
CFLAGS etc..(curious to see the performance as well as
any kind of bug fixes);

>> In any case, I suppose I can just copy /sbin/init from an existing
>> debian system but, then I might have issues with the
>> arch being different.
>
> No, that should work.
>

to my amazement it did work
(I compile sysv normally on the new system then just copied
init from a running debian to the new system).

on the other hand I'm seeing other issues at the moment besides init:
I dont have any file labels i.g. ls -Z shows:(/bin as an example)

drwxr-xr-x  2  root root ?  4096 Feb 16 22:38 bin
that question mark is on all files.
if I do a id -Z
id: --context (-Z) works only on a SELinux-enabled kernel
(keep in mind I still have to configure my /etc/ group/passwd
files, so this might have something to do with it);


> --
> russell@coker.com.au
> http://etbe.coker.com.au/          My Main Blog
> http://doc.coker.com.au/           My Documents Blog
>

Overall SELinux does load and there are avc being generated.
I think I just need to start from the beginning and make sure things
are proper.


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

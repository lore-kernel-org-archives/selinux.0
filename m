Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8RIOxsJ006514
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 14:24:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8RINEZt007169
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 18:23:14 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8RINBM3007166
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 18:23:12 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Howard Holm <hdholm@epoch.ncsc.mil>
Subject: Re: unlabeled_t and assert.te
Date: Sun, 28 Sep 2003 04:24:50 +1000
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
References: <200309272054.50553.russell@coker.com.au> <1064681300.16303.21.camel@moss-huskies>
In-Reply-To: <1064681300.16303.21.camel@moss-huskies>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309280424.50879.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 28 Sep 2003 02:48, Howard Holm wrote:
> While I agree that it would be beneficial to have assertions to catch
> stupid policy, I think your current solution has a serious drawback.  By

I agree that my current solution has some issues, which is why I think that a 
kernel change is required.

> removing file_type from unlabeled_t you break the notion that file_type
> includes all types on persistent media.

It changes that notion to "all types that are correctly labeled on persistent 
media".

> This means that existing rules
> such as
>
> # Relabel all files.
> allow $1_t file_type:dir { getattr read search relabelfrom relabelto };
> allow $1_t file_type:file_class_set { getattr relabelfrom relabelto };
>
> are no longer useful.  While you could change those to
>
> allow $1_t sysadmfile:dir { getattr read search relabelfrom relabelto };
> allow $1_t sysadmfile:file_class_set { getattr relabelfrom relabelto };
>
> as you suggest, not all files on persistent media are labeled with

I think you may have confused two of my messages here.  I changed my policy to 
not allow sysadm_t to relabel file_type as that would allow relabelling 
shadow_t and thus require the "auth" attribute for sysadm_t (and I want to 
limit that attribute to as few domains as possible).  The administrator can 
run setfiles to relabel to/from shadow_t in the default policy (which should 
be enough).  I want to add a number of new attributes for domains that can do 
dangerous things, then we can easily track which domains need to be audited, 
and we can have assertions to avoid accidentally giving unnecessary and 
dangerous privs when we don't need to.

In terms of unlabeled_t, if we remove the file_type attribute from it then we 
can always replace "file_type" with { file_type unlabeled_t } when we want to 
refer to unlabeled_t too.  It can be a bit painful while we track down the 
loose ends in the policy, but it's doable.

> sysadmfile.  In particular, I believe a number of devices, the shadow
> file, etc. don't have the sysadmfile attribute.  While sysadmfile may be

The devices are another issue.  I have been meaning to create a new attribute 
for them, then I can have an assertion that device nodes can only have 
suitable device types.  Allowing a device node to be relabeled to have (for 
example) shadow_t does no good.

I am not sure whether I should even put in policy allowing relabeling chr_file 
or blk_file classes from invalid types.  For some of these things I'm 
thinking of putting ifdef's around them, so on a small machine such as an 
iPaQ you can skip some of that (if your iPaQ gets messed you then you just 
wipe it).

> sufficient for relabeling most mistakes, it isn't sufficient to relabel
> files when policy updates make dramatic changes or when switching to a
> dramatically different policy.  It's true that doesn't happen often, and
> such dramatic changes are usually made with enforcing (at least) off.

That's a good point to raise.  Currently we don't permit relabelling from 
domain to file_type at all.  Also we have some problems when a process gets 
the type of a file.  If through gross manipulation of policy you get a 
process running as root:sysadm_r:sbin_t and a sane policy loaded then you'll 
find that init can't reap the process.

> Still, I don't think redefining the definition of file_type is the right
> answer.  Maybe, as you suggest more fundamental changes are needed, but
> that will require a lot more thought.

True, we don't want to rush in to having a new revision of the binary policy 
(and if it's back-ported to the old SE Linux it'll take one of the last two 
binary policy revision numbers available).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

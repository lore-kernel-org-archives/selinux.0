Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA12211
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 08:40:05 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1JDe4I14806
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 13:40:04 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h1JDe2f14795 for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 13:40:02 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Wayne Salamon <wsalamon@tislabs.com>
Subject: Re: Apache policy
Date: Wed, 19 Feb 2003 14:39:49 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.33.0302190715330.8753-200000@vox.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0302190715330.8753-200000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302191439.49511.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 Feb 2003 13:27, Wayne Salamon wrote:
> On Tue, 18 Feb 2003, Russell Coker wrote:
> > I've been working on re-writing the Apache policy.
>
>   I haven't been able to test this yet, but here's some comments:
>
> apache_macros.te:
>   - lines 61 and 67 domain_auto_trans via httpd_$1_script_t to
>     httpd_$1_script_t. Should trans through script_exec_t or script_r?_t.
>   - line 74 allows user to create file with label httpd_$1_script_t.
>     Should be exec_t, r?_t, etc.

I've already fixed those.  I'll put a new archive on my web site on 
http://www.coker.com.au/selinux/policy.tgz in a few minutes.

>   - Why does httpd_t need access to httpd_$1_script_t (line 110)?

httpd_t needs to be able to read files that cgi-bin scripts write such as 
httpd_$1_script_rw_t.  This is so that cgi-bin scripts can change other parts 
of the web site.  It may be a bad idea though, perhaps I should comment it 
out and just leave it as a suggestion for those who need it?

>   - Does $1_t need create permissions for script_exec_t? (around line 88)

No.  I can't find that in the version I sent you or the one in my current tree 
either.

>   - Uses ra_dir_file() macro; I've added global_macros (see patch)

Yes.

> apache.te
>   - Uses lock_domain() macro, not currently present in our tree.

I put the following in global_macros.te:
define(`lock_domain', `
type $1_lock_t, file_type, sysadmfile, lockfile;
file_type_auto_trans($1_t, var_lock_t, $1_lock_t)
')

> I've attached a patch that fixes up some of the other policy files
> affected by your changes. However, for httpadm.te, this problem is
> created:

I've just removed httpadm.te entirely from my tree.  My changes remove the 
need for it entirely.

The local administrator can define a new role in user.te for Apache 
administration and allow it to write to httpd_sys_script_exec_t and other 
similar file types.  I'll probably write a macro to allow such access (so you 
can easily permit samba to perform such modifications etc).


PS  There is still quite a bit of work to be done before this is release 
quality.  This is a job I had been avoiding for about a year because it was 
so painful and because the problems with the previous version hadn't bitten 
me badly enough.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5P6DL3E027633
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 02:13:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5P6CWss002970
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 06:12:32 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h5P6CUhY002967
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 06:12:31 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Colin Walters <walters@verbum.org>
Subject: Re: local policy changes, /var/lib access, syslogd
Date: Wed, 25 Jun 2003 16:13:08 +1000
Cc: selinux@tycho.nsa.gov
References: <1056505792.29159.43.camel@columbia> <200306251422.26574.russell@coker.com.au> <1056518166.744.20.camel@columbia>
In-Reply-To: <1056518166.744.20.camel@columbia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306251613.08168.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 Jun 2003 15:16, Colin Walters wrote:
> It just looks like this (for example):
>
> avc:  denied  { search } for  pid=5269 exe=/usr/lib/postfix/tlsmgr
> path=/lib dev=16:01 ino=32769 scontext=system_u:system_r:postfix_master_t
> tcontext=system_u:object_r:var_lib_t tclass=dir

tlsmgr apparently caches some information on connections (public keys for TLS 
I guess) under /var/lib.  Policy needs to be adjusted for this.  tlsmgr 
probably needs it's own domain.

Something like the following should do it.  Try it out and send me whatever 
variant on it works.  NB  I've never even compiled this policy snippet so 
there may be typos etc.

postfix.te:
postfix_server_domain(tlsmgr)
allow postfix_tlsmgr_t var_lib_t:dir search;
type postfix_tlscache_t, file_type, sysadmfile;
rw_dir_create_file(postfix_tlsmgr_t, postfix_tlscache_t)

postfix.fc:
/usr/lib/postfix/tlsmgr           system_u:object_r:postfix_tlsmgr_exec_t
/var/lib/whatever(.*)?		system_u:object_r:postfix_tlscache_t

> > Maybe libnss_db.
>
> Ok, interesting.  After I remove the 'db' lines in /etc/nsswitch.conf,
> the avc denial for /usr/lib/postfix/master goes away, but the one for
> /usr/lib/postfix/tlsmgr stays!  I guess I'm going to have to resort to
> stracing it here...

In the case of libnss_db then some "allow domain" rules could be used to grant 
access to the directories.  Steve really doesn't like this, so no such policy 
will ever get into the NSA tree (I've got some similar things in my nscd 
policy which he doesn't like).

Also note that libnss_db offers little benefit for information sources with 
less than 5000 entries.  Last time I did some serious benchmarking on this it 
seemed that about 10,000 entries was when you were forced to use something 
other than plain text files (but it depends on your use of course).

In Debian libnss-db seems to get installed by default and to get installed on 
upgrades.  This may be a bad idea as it often has issues (if it was half as 
good as the AIX equivalent then there would be no problems).  I'm inclined to 
believe that libnss-db should be re-written to work in a similar manner to 
AIX (which is considerably more difficult than you might imagine, otherwise 
I'd have done it), or deprecated in Debian.

I haven't raised this issue for discussion on debian-devel because I've got 
more than enough other things to bother with at the moment.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

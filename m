Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9G57XWt000764
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 01:07:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9G57WmR012815
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 05:07:32 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
        by jazzband.ncsc.mil  with ESMTP id h9G57Vjp012812 for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 05:07:32 GMT
Subject: Re: specifying groups of types
From: Chris PeBenito <pebenito@gentoo.org>
To: David Caplan <dac@tresys.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Russell Coker <russell@coker.com.au>,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <3F8C46E4.1030403@tresys.com>
References: <200310111435.46684.russell@coker.com.au>
	 <1066134168.5054.11.camel@moss-spartans.epoch.ncsc.mil>
	 <3F8C46E4.1030403@tresys.com>
Content-Type: text/plain
Message-Id: <1066280844.31190.34.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Thu, 16 Oct 2003 00:07:25 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Well I tried this out, and it worked, though I used simple examples:

portage.te:
create_dir_notdevfile(portage_t,{file_type -shadow_t})

admin_macros.te:
# Relabel most files.
allow $1_t {file_type -shadow_t}:dir { getattr read search relabelfrom relabelto };
allow $1_t {file_type -shadow_t}:file_class_set { getattr relabelfrom relabelto };

(where portage is Gentoo's packaging system)  I don't know anything
about yacc, so I can't comment on the implementation.  But the new
shadow assertions are what the first IRC discussion stemmed from.  They
were (correctly) not tripped by these statements, and sysadm_t can stat
but not read /etc/shadow.

On Tue, 2003-10-14 at 13:56, David Caplan wrote:
> I'd recommend trying this out and if you find it useful change the parse 
> rules.  I tested it on some real basic policy, so it may cause other 
> unintended problems.  I'm throwing it out more as a starting point 
> rather than something intended to be integrated into checkpolicy.

> Stephen Smalley wrote:
> > On Sat, 2003-10-11 at 00:35, Russell Coker wrote:
> > 
> >>Following a discussion on IRC, it occurs to me that it would be handy to have 
> >>the following in the policy language:
> >>allow some_domain { file_type !shadow_t }:...
> >>
> >>So we can specify everything in file_type except for shadow_t.
-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer, SELinux
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

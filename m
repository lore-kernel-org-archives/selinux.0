Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA2HhQWt026753
	for <selinux@tycho.nsa.gov>; Sun, 2 Nov 2003 12:43:26 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hA2HhPKl008399
	for <selinux@tycho.nsa.gov>; Sun, 2 Nov 2003 17:43:25 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
        by jazzband.ncsc.mil  with ESMTP id hA2HhO5m008396 for <selinux@tycho.nsa.gov>; Sun, 2 Nov 2003 17:43:24 GMT
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
Message-Id: <1067794997.5374.42.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Sun, 02 Nov 2003 11:43:18 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Was there any resolution to this?  I think this would be useful for
checkpolicy to have, but it hasn't been merged (at least on the
sourceforge cvs).  I don't remember seeing any official response from
the NSA team about it nor any criticism/improvements of it.

On Tue, 2003-10-14 at 13:56, David Caplan wrote:
> Russell,
> 
> Here's a quick hack that appears to work.  It turns off the type (or 
> list of types if used on an attribute) when building the bitmap of types 
> for a rule.  The syntax is to use a '-' in front of a type or attribute 
> name.
> 
> allow some_domain { file_type -shadow_t -null_device_t -exec_type}:...
> 
> The proper way to do this is in the yacc parsing section.  All I did was 
> allow '-' as the first character of an identifier (policy_scan.l) and 
> handle the subtraction of the type/attribute in 
> policy_parse.y:set_types().  The danger is that types (and anything 
> using the identifier definition) can be declared with '-' as the first 
> character and cause problems.  The advantage, in theory, is that 
> wherever a list of types/attributes is processed, the '-' notation can 
> be used to turn off types.  So, you should also be able to do something 
> like:
> 
> allow { auth -crond_t } file_type:...
> 
> Types/attributes are processed in order, and subsequent allow rules can 
> also override the subtraction.
> 
> I'd recommend trying this out and if you find it useful change the parse 
> rules.  I tested it on some real basic policy, so it may cause other 
> unintended problems.  I'm throwing it out more as a starting point 
> rather than something intended to be integrated into checkpolicy.
> 
> David
> 
> Stephen Smalley wrote:
> > On Sat, 2003-10-11 at 00:35, Russell Coker wrote:
> > 
> >>Following a discussion on IRC, it occurs to me that it would be handy to have 
> >>the following in the policy language:
> >>allow some_domain { file_type !shadow_t }:...
> >>
> >>So we can specify everything in file_type except for shadow_t.
> > 
> > 
> > Yes, although I'm not sure about the notation; might be better to
> > provide a set difference operator, e.g.
> > 	file_type - shadow_t
> > 
> > Are you offering to implement this enhancement to checkpolicy?
> > 
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

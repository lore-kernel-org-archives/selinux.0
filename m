Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA18097
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 10:47:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA05151
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 14:46:24 GMT
Received: from zai.com (zeta2.zai.com [12.47.112.34])
        by jazzband.ncsc.mil  with ESMTP id OAA05147 for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 14:46:23 GMT
Subject: Re: Configuration issues on a new installation
From: Warren Lerner <wdl@zai.com>
To: Michael Nyika <nyix@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20020626122402.14675.qmail@web40204.mail.yahoo.com>
References: <20020626122402.14675.qmail@web40204.mail.yahoo.com>
Content-Type: multipart/alternative; boundary="=-U56anxpvi1NPbKqw57xj"
Date: 26 Jun 2002 10:49:51 -0400
Message-Id: <1025102991.1409.17.camel@montyburns>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-U56anxpvi1NPbKqw57xj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Granted messages are only generated if you have specified auditallow
rules
in the configuration.  Denied messages are always generated unless you
specify auditdeny rules in the configuration.  A recently posted patch
(also committed to the sourceforge CVS tree) changes the 'auditdeny'
rules' to 'dontaudit' rules and provides more intuitive semantics.  See
the "Configuring the SELinux Policy" report for the precise syntax, or
look at examples in the example policy configuration.



On Wed, 2002-06-26 at 08:24, Michael Nyika wrote:

    Good-day, 
    I have found that i found the same avc denied messages
    on my 2.4.18 SElinux kernel. I manually edited the
    specific te files, just by looking at the messages
    from dmesg. i eliminated all but two. They are realted
    to the kernel_t domain and have to do with write
    permissions mainly.
    
    
    --- Brad Chapman <jabiru_croc@yahoo.com> wrote:
    > Everyone,
    > 
    >      I have just started using SELinux on my 2.4.18
    > system. I found an enormous
    > number of avc: denied messages in my dmesg and
    > attempted to remove them. So far
    > I have tweaked the devfs_contexts and the
    > policy.conf files (using
    > scripts/newrules.pl for policy.conf) since most of
    > the errors were related to
    > device files and system call commands. I have also
    > installed the SELinux devfsd
    > extension and added the config entries to my
    > devfsd.conf, to no apparent avail.
    > 
    >      What is the fastest way to eliminate most (if
    > not preferably all) of these
    > messages and put me closer to activating enforcing
    > mode?
    > 
    > Thanks,
    > 
    > Brad Chapman
    > 
    > =====
    > Brad Chapman
    > 
    > Permanent e-mails: kakadu_croc@yahoo.com
    > 		   jabiru_croc@yahoo.com
    > 		   tanami_croc@devel.lbsd.net
    > 
    > __________________________________________________
    > Do You Yahoo!?
    > LAUNCH - Your Yahoo! Music Experience
    > http://launch.yahoo.com
    > 
    > --
    > You have received this message because you are
    > subscribed to the selinux list.
    > If you no longer wish to subscribe, send mail to
    > majordomo@tycho.nsa.gov with
    > the words "unsubscribe selinux" without quotes as
    > the message.
    
    
    __________________________________________________
    Do You Yahoo!?
    Yahoo! - Official partner of 2002 FIFA World Cup
    http://fifaworldcup.yahoo.com
    
    --
    You have received this message because you are subscribed to the selinux list.
    If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
    the words "unsubscribe selinux" without quotes as the message.
    
    

--=-U56anxpvi1NPbKqw57xj
Content-Type: text/html; charset=utf-8

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/1.0.2">
</HEAD>
<BODY>
Granted messages are only generated if you have specified auditallow rules
<BR>
in the configuration.&nbsp; Denied messages are always generated unless you
<BR>
specify auditdeny rules in the configuration.&nbsp; A recently posted patch
<BR>
(also committed to the sourceforge CVS tree) changes the 'auditdeny'
<BR>
rules' to 'dontaudit' rules and provides more intuitive semantics.&nbsp; See
<BR>
the &quot;Configuring the SELinux Policy&quot; report for the precise syntax, or
<BR>
look at examples in the example policy configuration.
<BR>

<BR>

<BR>

<BR>
On Wed, 2002-06-26 at 08:24, Michael Nyika wrote:
    <BLOCKQUOTE>
<PRE><FONT COLOR="#737373"><FONT SIZE="3"><I>Good-day, </FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>I have found that i found the same avc denied messages</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>on my 2.4.18 SElinux kernel. I manually edited the</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>specific te files, just by looking at the messages</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>from dmesg. i eliminated all but two. They are realted</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>to the kernel_t domain and have to do with write</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>permissions mainly.</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I></FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I></FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>--- Brad Chapman &lt;jabiru_croc@yahoo.com&gt; wrote:</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; Everyone,</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; </FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt;      I have just started using SELinux on my 2.4.18</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; system. I found an enormous</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; number of avc: denied messages in my dmesg and</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; attempted to remove them. So far</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; I have tweaked the devfs_contexts and the</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; policy.conf files (using</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; scripts/newrules.pl for policy.conf) since most of</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; the errors were related to</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; device files and system call commands. I have also</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; installed the SELinux devfsd</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; extension and added the config entries to my</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; devfsd.conf, to no apparent avail.</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; </FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt;      What is the fastest way to eliminate most (if</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; not preferably all) of these</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; messages and put me closer to activating enforcing</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; mode?</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; </FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; Thanks,</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; </FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; Brad Chapman</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; </FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; =====</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; Brad Chapman</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; </FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; Permanent e-mails: kakadu_croc@yahoo.com</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; 		   jabiru_croc@yahoo.com</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; 		   tanami_croc@devel.lbsd.net</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; </FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; __________________________________________________</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; Do You Yahoo!?</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; LAUNCH - Your Yahoo! Music Experience</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; http://launch.yahoo.com</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; </FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; --</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; You have received this message because you are</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; subscribed to the selinux list.</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; If you no longer wish to subscribe, send mail to</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; majordomo@tycho.nsa.gov with</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; the words &quot;unsubscribe selinux&quot; without quotes as</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>&gt; the message.</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I></FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I></FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>__________________________________________________</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>Do You Yahoo!?</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>Yahoo! - Official partner of 2002 FIFA World Cup</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>http://fifaworldcup.yahoo.com</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I></FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>--</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>You have received this message because you are subscribed to the selinux list.</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I>the words &quot;unsubscribe selinux&quot; without quotes as the message.</FONT></FONT></I>
<FONT COLOR="#737373"><FONT SIZE="3"><I></FONT></FONT></I>
</PRE>
    </BLOCKQUOTE>
</BODY>
</HTML>

--=-U56anxpvi1NPbKqw57xj--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

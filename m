Message-ID: <3B7C7C69.E7B84C68@earthlink.net>
Date: Thu, 16 Aug 2001 19:07:37 -0700
From: John Scroggins <dataefx@earthlink.net>
MIME-Version: 1.0
To: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Subject: [Fwd: Partial TOC for Comment]
Content-Type: multipart/mixed;
 boundary="------------8A957F937161E9D5D978401E"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------8A957F937161E9D5D978401E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



-------- Original Message --------
X-Mozilla-Status: 8001
X-Mozilla-Status2: 00000000
BCC: dataefx@earthlink.net
Message-ID: <3B7C61C3.29886E04@earthlink.net>
Date: Thu, 16 Aug 2001 17:13:55 -0700
From: John Scroggins <dataefx@earthlink.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-lsm i586)
X-Accept-Language: en
MIME-Version: 1.0
Subject: Partial TOC for Comment
Content-Type:
multipart/mixed;boundary="------------F365DA8C7A05EE6BB97147FC"

Please give me your feedback/critique on the TOC, and if you can think
of additional subject headings (I do have more, but I want to see if
this is moving in the right directiom..)

TIA, 

John
--------------8A957F937161E9D5D978401E
Content-Type: text/html; charset=us-ascii;
 name="adm082001.html"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adm082001.html"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>
<HEAD>
 <META NAME="GENERATOR" CONTENT="SGML-Tools 1.0.9">
 <TITLE>SELinux Administrators Guide</TITLE>
 <LINK HREF="adm082001-1.html" REL=next>


</HEAD>
<BODY>
<A HREF="adm082001-1.html">Next</A>
Previous
Contents
<HR>
<H1>SELinux Administrators Guide</H1>

<H2>John Scroggins dataefx@earthlink.net </H2>
<H2>Christopher Mahmood ckm@suse.com </H2>August 2001
<P><HR>
<EM>ABSTRACT</EM>
<HR>
<P><HR>
<EM>Network security has become a focal point for the IT industry
 as a whole, based on the increased connectivity required by Government,
 and private sectors alike. One of the main concerns in system operation
 is protecting the core operating elements, given the fact that most
 attacks are intiated with the focus of gaining "
root"
, or system
 administrator level privliges. The Linux operating system has been
 well recieved in a wide range of network duties, its flexibility,
 and open source modeling is an excellent choice for the development
 of a "
secure"
 operating system called Security Enhanced Linux (SELinux).
 SELinux utilizes two separate security methods, Type Enforcement
 and Role Based Access. This document will assist the reader in determining
 some of the potential scenarios where the SELinux kernel would become
 beneficial, thus providing greater security than is available in
 the standard Linux kernel.</EM>
<HR>
<P>
<H2><A NAME="toc1">1.</A> <A HREF="adm082001-1.html">Introduction </A></H2>

<UL>
<LI><A HREF="adm082001-1.html#ss1.1">1.1 Operating System Security</A>
<LI><A HREF="adm082001-1.html#ss1.2">1.2 Enhancing System Security</A>
</UL>
<P>
<H2><A NAME="toc2">2.</A> <A HREF="adm082001-2.html">Security Controls </A></H2>

<UL>
<LI><A HREF="adm082001-2.html#ss2.1">2.1 Disrectionary Access </A>
<LI><A HREF="adm082001-2.html#ss2.2">2.2 Manadatory Access </A>
<LI><A HREF="adm082001-2.html#ss2.3">2.3 Domain and Type Enforcement </A>
<LI><A HREF="adm082001-2.html#ss2.4">2.4 Role Based Access</A>
<LI><A HREF="adm082001-2.html#ss2.5">2.5 Additional Control Measures</A>
</UL>
<P>
<H2><A NAME="toc3">3.</A> <A HREF="adm082001-3.html">SELinux Combined Controls</A></H2>

<UL>
<LI><A HREF="adm082001-3.html#ss3.1">3.1 Flask Security Architecture</A>
<LI><A HREF="adm082001-3.html#ss3.2">3.2 Linux Security Module (LSM) </A>
</UL>
<P>
<H2><A NAME="toc4">4.</A> <A HREF="adm082001-4.html">Configuring SELinux</A></H2>

<UL>
<LI><A HREF="adm082001-4.html#ss4.1">4.1 Defining User Roles </A>
<LI><A HREF="adm082001-4.html#ss4.2">4.2 Modifying the Default Type/Context Files </A>
</UL>
<HR>
<A HREF="adm082001-1.html">Next</A>
Previous
Contents
</BODY>
</HTML>


--------------8A957F937161E9D5D978401E
Content-Type: text/html; charset=us-ascii;
 name="adm082001-1.html"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adm082001-1.html"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>
<HEAD>
 <META NAME="GENERATOR" CONTENT="SGML-Tools 1.0.9">
 <TITLE>SELinux Administrators Guide: Introduction </TITLE>
 <LINK HREF="adm082001-2.html" REL=next>

 <LINK HREF="adm082001.html#toc1" REL=contents>
</HEAD>
<BODY>
<A HREF="adm082001-2.html">Next</A>
Previous
<A HREF="adm082001.html#toc1">Contents</A>
<HR>
<H2><A NAME="s1">1. Introduction </A></H2>

<H2><A NAME="ss1.1">1.1 Operating System Security</A>
</H2>

<H2><A NAME="ss1.2">1.2 Enhancing System Security</A>
</H2>

<HR>
<A HREF="adm082001-2.html">Next</A>
Previous
<A HREF="adm082001.html#toc1">Contents</A>
</BODY>
</HTML>


--------------8A957F937161E9D5D978401E
Content-Type: text/html; charset=us-ascii;
 name="adm082001-2.html"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adm082001-2.html"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>
<HEAD>
 <META NAME="GENERATOR" CONTENT="SGML-Tools 1.0.9">
 <TITLE>SELinux Administrators Guide: Security Controls </TITLE>
 <LINK HREF="adm082001-3.html" REL=next>
 <LINK HREF="adm082001-1.html" REL=previous>
 <LINK HREF="adm082001.html#toc2" REL=contents>
</HEAD>
<BODY>
<A HREF="adm082001-3.html">Next</A>
<A HREF="adm082001-1.html">Previous</A>
<A HREF="adm082001.html#toc2">Contents</A>
<HR>
<H2><A NAME="s2">2. Security Controls </A></H2>

<H2><A NAME="ss2.1">2.1 Disrectionary Access </A>
</H2>

<H2><A NAME="ss2.2">2.2 Manadatory Access </A>
</H2>

<H2><A NAME="ss2.3">2.3 Domain and Type Enforcement </A>
</H2>

<H2><A NAME="ss2.4">2.4 Role Based Access</A>
</H2>

<H2><A NAME="ss2.5">2.5 Additional Control Measures</A>
</H2>

<HR>
<A HREF="adm082001-3.html">Next</A>
<A HREF="adm082001-1.html">Previous</A>
<A HREF="adm082001.html#toc2">Contents</A>
</BODY>
</HTML>


--------------8A957F937161E9D5D978401E
Content-Type: text/html; charset=us-ascii;
 name="adm082001-3.html"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adm082001-3.html"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>
<HEAD>
 <META NAME="GENERATOR" CONTENT="SGML-Tools 1.0.9">
 <TITLE>SELinux Administrators Guide: SELinux Combined Controls</TITLE>
 <LINK HREF="adm082001-4.html" REL=next>
 <LINK HREF="adm082001-2.html" REL=previous>
 <LINK HREF="adm082001.html#toc3" REL=contents>
</HEAD>
<BODY>
<A HREF="adm082001-4.html">Next</A>
<A HREF="adm082001-2.html">Previous</A>
<A HREF="adm082001.html#toc3">Contents</A>
<HR>
<H2><A NAME="s3">3. SELinux Combined Controls</A></H2>

<H2><A NAME="ss3.1">3.1 Flask Security Architecture</A>
</H2>

<H2><A NAME="ss3.2">3.2 Linux Security Module (LSM) </A>
</H2>

<HR>
<A HREF="adm082001-4.html">Next</A>
<A HREF="adm082001-2.html">Previous</A>
<A HREF="adm082001.html#toc3">Contents</A>
</BODY>
</HTML>


--------------8A957F937161E9D5D978401E
Content-Type: text/html; charset=us-ascii;
 name="adm082001-4.html"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adm082001-4.html"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>
<HEAD>
 <META NAME="GENERATOR" CONTENT="SGML-Tools 1.0.9">
 <TITLE>SELinux Administrators Guide: Configuring SELinux</TITLE>
 <LINK HREF="adm082001-3.html" REL=previous>
 <LINK HREF="adm082001.html#toc4" REL=contents>
</HEAD>
<BODY>
Next
<A HREF="adm082001-3.html">Previous</A>
<A HREF="adm082001.html#toc4">Contents</A>
<HR>
<H2><A NAME="s4">4. Configuring SELinux</A></H2>

<H2><A NAME="ss4.1">4.1 Defining User Roles </A>
</H2>

<H2><A NAME="ss4.2">4.2 Modifying the Default Type/Context Files </A>
</H2>

<HR>
Next
<A HREF="adm082001-3.html">Previous</A>
<A HREF="adm082001.html#toc4">Contents</A>
</BODY>
</HTML>


--------------8A957F937161E9D5D978401E--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB7KUTIi000961
	for <selinux@tycho.nsa.gov>; Tue, 7 Dec 2004 15:30:29 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB7KUWmm027822
	for <selinux@tycho.nsa.gov>; Tue, 7 Dec 2004 20:30:32 GMT
Date: Tue, 7 Dec 2004 20:41:11 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: "Luis Fernando C. Talora" <luis.talora@iesa.com.br>
Cc: " (SELinux@tycho.nsa.gov)" <SELinux@tycho.nsa.gov>
Subject: Re: Problem with SELinux and Squid+Winbind+Samba
Message-ID: <20041207204111.GC5153@lkcl.net>
References: <5D201EB6E3041946BC4F8F6A14296132607EE3@svnt4-5.inepar.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5D201EB6E3041946BC4F8F6A14296132607EE3@svnt4-5.inepar.com.br>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 07, 2004 at 09:19:14AM -0200, Luis Fernando C. Talora wrote:
> Fellows,
>  
> I?m trying to put a server running Squid with Microsoft Windows Active
> Directory integrated authentication (using Samba 3 and Winbind). When I
> start the squid service, I get the following message (it repeats itself many
> times):
>  
> Dec  7 08:48:56 svux8-250 kernel: audit(1102416536.028:0): avc:  denied  {
> getattr } for  pid=3825 exe=/usr/lib/squid/wb_ntlmauth
> path=/var/run/winbindd/pipe dev=hda7 ino=627398
> scontext=root:system_r:squid_t tcontext=root:object_r:var_run_t
> tclass=sock_file
  
> Since I?m new in SELinux, I have no idea how to solve this. Could someone
> give some help?
 
  ah.   there's quite a lot involved!

  the first thing is, ideally, to write a separate policy for winbindd,
  esp. making /var/run/winbindd have its own file context.

  then you can grant wb_ntlmmauth (or squid_t) the right to access
  /var/run/winbindd/pipe.

 ... anyone got any opinions as to whether winbind should be creating a
 socket in /var/run?  is that FHS compliant?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

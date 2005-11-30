Subject: Re: Linux 2.6.13.4 --> 2.6.14.3 & security contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sami Farin <safari-selinux@safari.iki.fi>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <20051129204523.GA29885@m.safari.iki.fi>
References: <20051129204523.GA29885@m.safari.iki.fi>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 10:52:00 -0500
Message-Id: <1133365920.26593.338.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-29 at 22:45 +0200, Sami Farin wrote:
> After "upgrading" from 2.6.13.4 to 2.6.14.3, selinux
> stopped working as expected.
> Security context is not created for new files.
> 
> For example, when I do "touch ~/hirvi ; ls -lZ ~/hirvi"
> I get
> -rw-rw----  safari   safari                                    /home/safari/hirvi
> 
> and after "useradd -M foobar" I have to do
> "restorecon /etc/shadow* /etc/passwd* /etc/group* /etc/gshadow*"
> or I can't add more users.  And "restorecon /etc/ld.so.c*"
> needed after running ldconfig.
> 
> With 2.6.13.4 I used fedora's selinux-policy-targeted-1*, and
> with 2.6.14.3 the same one.  When I noticed all is not fine,
> I "upgraded" to serefpolicy 2.0.5.
> After disabling execmem globally, it seemed to work except
> that security context is not created for new files.
> 
> So, all I would like to know is how to get 2.6.13.4 behavior back
> (_and_ while running 2.6.14.3) with smallest possible amount of sweat
> and blood.
> 
> $ id
> uid=500(safari) gid=500(safari) groups=37(rpm),500(safari),509(xuser),546(sound) context=user_u:system_r:unconfined_t:s0-s0:c0.c255

What filesystem type are you using?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

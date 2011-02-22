Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1MMgn4r024658
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2011 17:42:49 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1MMgm8e020598
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2011 22:42:49 GMT
Message-ID: <4D643BE6.5060403@redhat.com>
Date: Tue, 22 Feb 2011 17:42:46 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: chanson@TrustedCS.com
CC: selinux@tycho.nsa.gov
Subject: Re: I want to add the following to mcs constraints in SELinux policy
References: <4D642363.6050403@redhat.com> <170D6ABBBA770349AA49582A86FCED1503A84572@HAVOC.tcs-sec.com>
In-Reply-To: <170D6ABBBA770349AA49582A86FCED1503A84572@HAVOC.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/22/2011 05:32 PM, chanson@TrustedCS.com wrote:
>  
>>
>> mlsconstrain { tcp_socket udp_socket rawip_socket } node_bind
>> 	(( h1 dom h2 ) or ( t1 == mcsnetwrite ));
>>
>>
>> For some reason we do not do this in MLS policy.  Does anyone 
>> know why we don't do this for MLS?
>>
> 
> I believe it is because we didn't make ports in MLS labeled objects. On
> other trusted network implementations, there was the idea of
> polyinstantiated ports so every label could always have one. We didn't
> do that on Linux, we just allow the port access to be first come, first
> serve and let TE instead of MLS define what application should be using
> the port. There could be connections coming into to the port at multiple
> levels if application is a trusted service and has the ability to talk
> to each of the clients. 
> 
> -Chad
>  
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 
Well it does not seem to work on MCS node_bind anyways, now I need to
look into some of Paul Moore stuff to see if I can get separation.

I want to setup rules that says a_t:MCS1 can bind to a host port
(127.0.0.2) only if the host is labeled MCS1 And block it if it is
labeled MCS2
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk1kO+YACgkQrlYvE4MpobMwVgCg1yckFdpM1s6jAV/2QolxuyoY
1WkAnRhm5O0km4p116ymRalke5pCCCdm
=sBT0
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

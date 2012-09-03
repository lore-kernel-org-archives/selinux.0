Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q83N0Db9027184
	for <selinux@tycho.nsa.gov>; Mon, 3 Sep 2012 19:00:13 -0400
Received: by obbwd18 with SMTP id wd18so11406624obb.12
        for <selinux@tycho.nsa.gov>; Mon, 03 Sep 2012 16:00:02 -0700 (PDT)
Message-ID: <5045366C.5060005@maxqe.com>
Date: Mon, 03 Sep 2012 17:59:56 -0500
From: Larry <larry-lists@maxqe.com>
Reply-To: larry-lists@maxqe.com
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: RBAC to SELinux policy migration
References: <CADxHy9eYOVaVK22ZCi_UregXFwsOwtb1B=Tyygh=87tECsYwhg@mail.gmail.com>
In-Reply-To: <CADxHy9eYOVaVK22ZCi_UregXFwsOwtb1B=Tyygh=87tECsYwhg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 09/03/2012 05:41 PM, Marcel Butucea wrote:
> Hello SELinux Team,
> 
> As I am a beginner in deciphering the depths of SELinux I come to you
> with the following predicament in hope of guidance and help:
> 
> We are migrating an application from Solaris to Linux and the main user
> is allowed, through the use of RBAC roles, to run a few system commands
> like svccfg/svcadm (chkconfig on redhat).
> 
> Is it possible, using only SElinux (no sudo), to allow a normal user to
> run chkconfig off/on <service> (basically giving it the ability to
> add/remove services) ?(my ultimate goal would be to allow this user to
> run other "root-only" utilities as well). One of my concerns is that
> chkconfig might have some internal check for the uid of the calling
> user, ergo blocking this account from running the utility irrespective
> of my selinux policy, is my worry legitimate or am I imagining things ?
> 
> My approach was to try to create an SElinux user with a corresponding
> SElinux role that manages the app's domain/type and is allowed to
> transition to all other domains required to run chkconfig, tcpdump or
> any other system utility usually restricted to root access only. All my
> attempts so far have failed, so my second question would be where could
> I find good documentation that applies to this specific problem ?
> 
> Thank you for your support!
> 
> Best Regards,
> 
> Marcel
> 

This seems like an issue better suited for sudo. Do you have a
limitation of some sort which is ruling out the use of sudo  ?




- -- 


Larry Brower, CCNA

Fedora Ambassador - North America
Fedora Quality Assurance
lbrower@fedoraproject.org
http://www.fedoraproject.org/
-----BEGIN PGP SIGNATURE-----
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBCgAGBQJQRTZsAAoJEPXCUD/44PWqUksQAMd9dApaqXxUKbS7EKMvtR7U
RDLG5QbMThuJpywSWejraM5WWyG+7iTqaP90lIRtntZPuS1qkKH65oPJiDZw7tX0
rXoQ9oFMwZAHXbuhEHUJQykQKNnN5euVmv8261wz/wPyVEdNCRRipA4UFyOzg3oa
DXAnlbWDKqoZ7t31ZwG5HKLEqwf9eSRATAT90Wx2FwvVznStukPvYtSfgiio6pYh
qk77yr23nCGNgq4b6G+yb9JfKV/SNyOBPLUkF0hQrk0YYURovvRjKe980i7DFkn+
WMUc9gFtlGO0zklFOOAR+HhY5FZ3rc12qQhrWOGtKfNT5j1VuH4q/w0Nf+XZV4lo
ZbdWL9yf7mNg7X1OnL4Gi5lL/q635FHGEnNrYi09kXAx/87dV511RrwCE9pNdMNe
y4KVEQ6ugQv+w+5DIddnz0XpBWMMxPskZwaOLIovM/mN7vnTALkoOQUhAC2iQ0Df
lQuudqqu2cL17Iy7abOC0B1Xqqwm2j9Hbl58Vw5l16LCzJxkHy+82upFIFjgpU05
5CzVccIVtWbnkNVWUw6HoiwrCY4N0N75KJ8zIqlP4DihwIAz20Tw7CBk2Ou47LO6
98lWpR2o4BmFBEWSWwSAjVUr7/jDQoAPNaFNnYR9myy0PPYod9NfRxsUh0uDUqg5
2ZGQPlldkQNCBIW8M29E
=SRFw
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

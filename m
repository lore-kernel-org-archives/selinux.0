Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB2AVjKm014098
 for <selinux@tycho.nsa.gov>; Wed, 2 Dec 2015 05:31:45 -0500
Received: by wmww144 with SMTP id w144so50519368wmw.0
 for <selinux@tycho.nsa.gov>; Wed, 02 Dec 2015 02:31:34 -0800 (PST)
Received: from x250 ([84.245.63.179])
 by smtp.gmail.com with ESMTPSA id cw3sm2117653wjb.26.2015.12.02.02.31.34
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Wed, 02 Dec 2015 02:31:34 -0800 (PST)
Date: Wed, 2 Dec 2015 11:31:32 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: continuation of systemd/SELinux discussion from Github
Message-ID: <20151202103131.GB1028@x250>
References: <20151202101801.GA1028@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <20151202101801.GA1028@x250>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, Dec 02, 2015 at 11:18:01AM +0100, Dominick Grift wrote:
> Let's continue the discussion here.
> 
> The last answered questionnaire is below, any further questions or
> comments?:
> 

I will start by adding a few comments.

I agree that the SELinux user space object manager support is a bit
fragile and rough edged. (I actually recently sent a message to this
list pointing this out)

Either something is wrong with that support or its documentation.

I noticed that many developer focus a lot on uid=0, and forget that
these day's you do not need access to uid=0 to ruin someones life.

To me, from an SELinux perspective at least, a process is just a process
regardless of the UID it is associated with.

The most common use of SELinux is arguably distributions using it to
enforce their policy on their customers hardware, This is fine but
please remember that some customers which to be able to keep that
discretion to them selves.

I think that means in practice that one should keep that in mind at all
times when something is implemented by not making any assumptions about
whether something is useful or not when that is not appropriate.

You may use access control for one this and I may use if for
another. Your threat model may not align with my threat model.

Let us not forget that SELinux is supposed to be a "flexible" MAC, this
is one of the reasons why we use SELinux and not, say SMACK

Thank you. That is all for now

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWXsh/AAoJENAR6kfG5xmcM5sL/2m5mL9S947+4yy82L6SzC1g
GV6vjG1D+FSwa0tMPXNTuYJcLC28TnHv8aYO6v6sadDW4nPsm1li4PxziScdGmzz
/F1WeCaJ8hFXlJYCvVc4brlREiOiz08BlZob1SOpvsVDrgeYIsvI1CTKsRDQP86u
5OsVDgLim5slcq5rFcYN1eAsDj7KpOw9ozyFg2qRWdACw/TageKu0FNnHr6GtCRG
pva3Y4Pp3cmH+vaSiffciypuzy+wKbZdUbEaUp7QIIqHJ5IICbZ8qFw3mLZUtziW
scglWAzrlfhsiwwVusPjPbhhZAcdRJtEPcve/dmfpQRFtImt2FeIWabjMa98QmnY
HPH/2jZJIr/tGz/PIkT4SLsFRc3fl3LdV5lqLO5GGpvWxw0Xq1ke3TV5J8WCSitt
lGnSdkzRqC9sasSOBS5cilUpYeOrq37LOwVLu12kamwxJpIYeBLnur/f6lcrQzSU
OZDlpU3u59i3oyFbFauHe2p7wLbDKGxOpCEsv95Now==
=5gZK
-----END PGP SIGNATURE-----

From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: janak@us.ibm.com
Subject: Re: [RFC] [PATCH] Extend vixie-cron to allow cron jobs at multiple security contexts
Date: Wed, 12 Apr 2006 18:59:43 +1000
Cc: jvdias@redhat.com, stevegr@master.debian.org, ciaranm@gentoo.org,
        dwalsh@redhat.com, sgrubb@redhat.com, sds@tycho.nsa.gov,
        selinux@tycho.nsa.gov
References: <1144422989.7681.6.camel@hobbes.atlanta.ibm.com>
In-Reply-To: <1144422989.7681.6.camel@hobbes.atlanta.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200604121859.50999.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 08 April 2006 01:16, JANAK DESAI <janak@us.ibm.com> wrote:
> +				if ((strlen(pw->pw_name) +
> +				     strlen((char *)context)) >= sizeof User) {

Shouldn't that be the following instead?
 				if ((strlen(pw->pw_name) +
 				     strlen((char *)context)) + 2 > sizeof User) {

> +			if (strlen(optarg) >= sizeof User)

Shouldn't that be the following instead?
			if (strlen(optarg) + 1 >= sizeof(User) )

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

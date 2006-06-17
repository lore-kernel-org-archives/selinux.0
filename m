From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] pam_namespace : allow use of X and gdm =?iso-8859-1?q?while=09polyinstantiating?= /tmp
Date: Sat, 17 Jun 2006 10:30:56 +1000
Cc: janak@us.ibm.com, "Timothy R. Chavez" <tinytim@us.ibm.com>,
        sgrubb@redhat.com, tmraz@redhat.com, klaus@atsec.com,
        Valdis.Kletnieks@vt.edu, sds@tycho.nsa.gov, selinux@tycho.nsa.gov
References: <1150426606.12904.3.camel@localhost.localdomain> <1150480302.19866.1.camel@localhost.localdomain> <4492F9F8.2090508@redhat.com>
In-Reply-To: <4492F9F8.2090508@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606171030.57042.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 17 June 2006 04:35, Daniel J Walsh <dwalsh@redhat.com> wrote:
> BTW, I talked to the X-Windows developers here and they are looking into
> getting rid of the /tmp requirement all together for X-Windows.

What exactly do you mean?  Do you mean moving it somewhere else such 
as /var/run or do you mean using TCP instead?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

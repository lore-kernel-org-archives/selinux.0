From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] pam_namespace : allow use of X and gdm while polyinstantiating /tmp
Date: Sat, 17 Jun 2006 20:27:51 +1000
Cc: janak@us.ibm.com, "Timothy R. Chavez" <tinytim@us.ibm.com>,
        sgrubb@redhat.com, tmraz@redhat.com, klaus@atsec.com,
        Valdis.Kletnieks@vt.edu, sds@tycho.nsa.gov, selinux@tycho.nsa.gov
References: <1150426606.12904.3.camel@localhost.localdomain> <200606171030.57042.russell@coker.com.au> <4493D0DE.3050805@redhat.com>
In-Reply-To: <4493D0DE.3050805@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606172027.51997.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 17 June 2006 19:52, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > What exactly do you mean?  Do you mean moving it somewhere else such
> > as /var/run or do you mean using TCP instead?
>
> They are talking about using abstract namespaces.

What exactly do you mean?  Do you mean having the X server or the XDM program 
create PI directories?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5GJv4op003342
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 15:57:05 -0400
Received: from web36609.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k5GJv3Ig017642
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 19:57:03 GMT
Message-ID: <20060616195701.55154.qmail@web36609.mail.mud.yahoo.com>
Date: Fri, 16 Jun 2006 12:57:01 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH] pam_namespace : allow use of X and gdm while polyinstantiating /tmp
To: Daniel J Walsh <dwalsh@redhat.com>, janak@us.ibm.com
Cc: "Timothy R. Chavez" <tinytim@us.ibm.com>, sgrubb@redhat.com,
        tmraz@redhat.com, klaus@atsec.com, Valdis.Kletnieks@vt.edu,
        sds@tycho.nsa.gov, russell@coker.com.au, selinux@tycho.nsa.gov
In-Reply-To: <4492F9F8.2090508@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Daniel J Walsh <dwalsh@redhat.com> wrote:

> BTW, I talked to the X-Windows developers here and
> they are looking into 
> getting rid of the /tmp requirement all together for
> X-Windows.

You might want to see if they're still using
any of the shared memory transports that cropped
up in the mid 90's.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

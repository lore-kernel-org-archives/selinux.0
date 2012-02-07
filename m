Subject: Re: SELinux query
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Devendra Talegaonkar <Devendra.Talegaonkar@kpitcummins.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4F31591B.8090402@redhat.com>
References: <A2F8C1DC917AEC409BE49BB1E1DEF34D1FDF6F78@KCHJEXMB02.kpit.com>
	 <4F2FE956.3050403@redhat.com>
	 <A2F8C1DC917AEC409BE49BB1E1DEF34D1FDF7074@KCHJEXMB02.kpit.com>
	 <4F31591B.8090402@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Feb 2012 12:37:51 -0500
Message-ID: <1328636271.2162.56.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/07/2012 01:00 AM, Devendra Talegaonkar wrote:
> Problem is solved. I am trying SELinux on IMX-53 QSB target. I am
> using kernel 2.6.38. Is there any information available about
> compiling and running SELinux on embedded targets?

Some older resources on embedded SELinux can be found at:
http://elinux.org/SELinux

Also, in the case of Android, information about using SELinux can be
found at:
http://selinuxproject.org/page/SEAndroid

While your target might not be running Android, you may nonetheless find
parts of our SE Android reference implementation useful, particularly
with its emphasis on a minimal port of the SELinux userspace and a small
policy written from scratch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

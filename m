Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5R2jCj0008199
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 22:45:12 -0400
Received: from mailhub.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5R2jAdE003146
	for <selinux@tycho.nsa.gov>; Tue, 27 Jun 2006 02:45:10 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [redhat-lspp] Re: [RFC 3/7] NetLabel: CIPSOv4 engine
Date: Mon, 26 Jun 2006 22:45:02 -0400
Cc: Joe Nall <joe@nall.com>, David Miller <davem@davemloft.net>,
        jmorris@redhat.com, Stephen Smalley <sds@epoch.ncsc.mil>,
        RedHat LSPP <redhat-lspp@redhat.com>,
        linux-security-module@vger.kernel.org,
        SELinux List <selinux@tycho.nsa.gov>, netdev@vger.kernel.org,
        Steve Grubb <sgrubb@redhat.com>
References: <20060621194234.979661000@flek.zko.hp.com> <F5329247-1566-4989-954B-A199240DC89F@nall.com> <Pine.LNX.4.64.0606262031010.26545@d.namei>
In-Reply-To: <Pine.LNX.4.64.0606262031010.26545@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606262245.03628.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 26 June 2006 8:33 pm, James Morris wrote:
> On Mon, 26 Jun 2006, Joe Nall wrote:
> > For all of the EAL4 LSPP Linux evaluation work is being done by Red
> > Hat/IBM/HP/atsec and others to be useful to integrators, there has to be
> > basic (e.g. CIPSO) multilevel network interoperability with existing
> > multilevel systems and good (e.g IPSec) multilevel networking between
> > SELinux systems.
>
> Just to be clear, my understanding is that the native xfrm labeling is
> suitable for LSPP evaluation, as distinct from CIPSO being desired by
> system integrators from an interoperability point of view.
>

True, but I believe the point Joe was trying to make was that providing 
support for only one labeling mechanism would limit the usefulness of the 
evaluated configuration.  What good is a Common Criteria evaluation if it 
doesn't contain the features that user's require?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

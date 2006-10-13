Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9DHOccH008117
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 13:24:38 -0400
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9DHNueg004424
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 17:23:57 GMT
Date: Fri, 13 Oct 2006 12:24:28 -0500
From: Klaus Weidner <klaus@atsec.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Matt Anderson <mra@hp.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: Re: context_sensitivity_{get|set}
Message-ID: <20061013172428.GJ28525@w-m-p.com>
References: <452E955F.2050407@hp.com> <1160748247.14346.26.camel@moss-spartans.epoch.ncsc.mil> <20061013154729.GI28525@w-m-p.com> <452FBC4B.2060703@hp.com> <452FBE34.2000202@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <452FBE34.2000202@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Oct 13, 2006 at 12:26:28PM -0400, Paul Moore wrote:
> Ungh, sorry, but I just thought of another reason to go with the "_mlslow_" and
> "_mlshigh_" naming convention ... the concept of using the lower portion of the
> MLS label as the effective label and the higher portion as the clearance label
> is not hardcoded into the security server, it is part of the MLS constraints in
> the policy (if memory serves correctly).  With this in mind I would strongly
> argue against using "effective" or "clearance" in the interface names as this
> could be very confusing for application developers who decide to use the SELinux
> MLS concept for something other than the standard LSPP usage case.

I'm convinced, these names also avoid the level vs sensitivity confusion that
Casey brought up.

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

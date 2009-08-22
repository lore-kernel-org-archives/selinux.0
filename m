Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7M3q28T022694
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 23:52:02 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7M3pS1x026306
	for <selinux@tycho.nsa.gov>; Sat, 22 Aug 2009 03:51:28 GMT
Received: from anzu.internal.golden-gryphon.com (tiamat.golden-gryphon.com [204.117.95.118])
	(authenticated bits=128)
	by ladon.golden-gryphon.com (8.14.3/8.14.3/Debian-5) with ESMTP id n7M3gfF9011013
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 22:42:43 -0500
Received: from anzu.internal.golden-gryphon.com.internal.golden-gryphon.com (localhost [127.0.0.1])
	by anzu.internal.golden-gryphon.com (8.14.3/8.14.3/Debian-9) with ESMTP id n7M3R2vO019037
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 22:27:02 -0500
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Subject: Re: Semodule syntax is broken.
References: <4A8EC2F9.3040707@redhat.com>
	<87eir5rv3e.fsf@anzu.internal.golden-gryphon.com>
	<4A8EDE77.3050003@redhat.com>
Date: Fri, 21 Aug 2009 22:27:02 -0500
In-Reply-To: <4A8EDE77.3050003@redhat.com> (Daniel J. Walsh's message of "Fri,
	21 Aug 2009 13:50:47 -0400")
Message-ID: <87ocq834vt.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Aug 21 2009, Daniel J Walsh wrote:


> So proposal
>
> semodule -r : No Change in default behaviour
>	 -F : Permanantly removes policy package, leaving POLICY.exclude
>	      flag in module store 
>
> semodule -u : Install if package not installed, upgrade otherwise)
> semodule -f : Only upgrade modules that are currently installed)
> semodule -i : No change.
>	All will get a warning message if a module they are trying to
>	install has a POLICY.exclude flag 
>          -q : Shut up Warning messages
>          -F : Remove POLICY.exclude flag and install the package

        Sounds good to me.

        manoj
-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

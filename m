Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8IM2oiu021549
	for <selinux@tycho.nsa.gov>; Fri, 18 Sep 2009 18:02:50 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8IM26qw001603
	for <selinux@tycho.nsa.gov>; Fri, 18 Sep 2009 22:02:06 GMT
Received: from anzu.internal.golden-gryphon.com (tiamat.golden-gryphon.com [204.117.95.118])
	(authenticated bits=128)
	by ladon.golden-gryphon.com (8.14.3/8.14.3/Debian-5) with ESMTP id n8ILuimn027446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Fri, 18 Sep 2009 16:56:45 -0500
Received: from anzu.internal.golden-gryphon.com.internal.golden-gryphon.com (localhost [127.0.0.1])
	by anzu.internal.golden-gryphon.com (8.14.3/8.14.3/Debian-9) with ESMTP id n8ILuAWx026277
	for <selinux@tycho.nsa.gov>; Fri, 18 Sep 2009 16:56:11 -0500
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Subject: Re: policycoreutils, sepolgen (sepolgen-ifgen) issues on Debian
References: <87d46y1lwd.fsf@anzu.internal.golden-gryphon.com>
	<878whm1gr5.fsf@anzu.internal.golden-gryphon.com>
	<87fxbq30u5.fsf@anzu.internal.golden-gryphon.com>
	<4AB0FDBD.8030200@manicmethod.com>
	<87fxamg7pm.fsf@anzu.internal.golden-gryphon.com>
	<4AB150F1.6030700@manicmethod.com>
Date: Fri, 18 Sep 2009 16:56:10 -0500
In-Reply-To: <4AB150F1.6030700@manicmethod.com> (Joshua Brindle's message of
	"Wed, 16 Sep 2009 16:56:17 -0400")
Message-ID: <87zl8rex39.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 16 2009, Joshua Brindle wrote:

>
> I'm not a fan of fixing things by making them configurable. This
> really should just use a standard location of
> /usr/share/selinux/<type>/devel.

> Would you carry the previous patch that changed the path until RHEL
> and Fedora get updated then we can merge it upstream?

        Sure, that would not be a problem.

        manoj
-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

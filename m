Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3ED6tjL017148
 for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2016 09:06:55 -0400
From: Daniel Jurgens <danielj@mellanox.com>
To: Ira Weiny <ira.weiny@intel.com>, "Hefty, Sean" <sean.hefty@intel.com>
CC: Hal Rosenstock <hal@dev.mellanox.co.il>, Jason Gunthorpe
 <jgunthorpe@obsidianresearch.com>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [RFC PATCH v2 00/13] SELinux support for Infiniband RDMA
Date: Thu, 14 Apr 2016 13:06:49 +0000
Message-ID: <AM2PR05MB110572367C5FEDDC4C77A38FC4970@AM2PR05MB1105.eurprd05.prod.outlook.com>
References: <DB5PR05MB111168B6670B36F12979705BC4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
 <20160411221210.GA5861@obsidianresearch.com>
 <DB5PR05MB1111E6A72480FF78AAB12747C4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
 <20160411231250.GB5861@obsidianresearch.com>
 <DB5PR05MB1111F04641E58609E51A9630C4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
 <20160412000621.GD5861@obsidianresearch.com>
 <570C85F7.5010101@dev.mellanox.co.il>
 <1828884A29C6694DAF28B7E6B8A82373AB040ABA@ORSMSX109.amr.corp.intel.com>
 <570DD3F5.2060302@dev.mellanox.co.il>
 <1828884A29C6694DAF28B7E6B8A82373AB041285@ORSMSX109.amr.corp.intel.com>
 <20160414002718.GA6660@rhel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 4/13/2016 7:27 PM, Ira Weiny wrote:
> On Wed, Apr 13, 2016 at 04:47:48PM +0000, Sean Hefty wrote:
>>> Former (multicast modifications of fabric) also requires restricting
>>> arbitrary UD QPs as well as QP1 as SA access is QPn (n > 0) <-> QP1.
>>
>> The SA could have an option to ignore all requests that do not originate QP1,
>> then protect access to QP1 on the client nodes.
> 
> I'm not really sure what we are protecting against here.  Is it simply DoS
> against the SA?
> 
> Ira
> 
>> --
>>
>> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

A DoS attack against the SA is out of scope for this proposed change.
SELinux provides access control.  Preventing a user from maliciously
doing something you've given them permission to do is a different problem.

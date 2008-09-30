Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8U7qtcX005561
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 03:52:55 -0400
Received: from tyo202.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8U7qr8J002274
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 07:52:54 GMT
Message-ID: <48E1DAAC.6040403@ak.jp.nec.com>
Date: Tue, 30 Sep 2008 16:52:12 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
Subject: Re: sepostgresql.pp conflicts on F9 (Re: How to find SELinux	policy
 type?)
References: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org>	 <48D98748.6090408@ak.jp.nec.com> <9546.1222400049@turing-police.cc.vt.edu>	 <48DC5C16.9040607@ak.jp.nec.com>	 <1222421896.24783.7.camel@sulphur.notebook.internal>	 <48DCB88E.3080503@kaigai.gr.jp>	 <1222425714.24783.13.camel@sulphur.notebook.internal>	 <48DCE45B.3040900@kaigai.gr.jp> <48DE5718.2050404@kaigai.gr.jp>	 <48E1A8BF.6060107@ak.jp.nec.com> <1222759447.29878.3.camel@sulphur.notebook.internal>
In-Reply-To: <1222759447.29878.3.camel@sulphur.notebook.internal>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dominick Grift wrote:
> On Tue, 2008-09-30 at 13:19 +0900, KaiGai Kohei wrote:
>> Dominick,
>>
>> Show the package:
>>   http://koji.fedoraproject.org/koji/buildinfo?buildID=64748
>>
>> It will be able to help your matter.
> 
> hello
> 
> sh-3.2# rpm -Uvh sepostgresql-8.3.4-2.1067.fc9.x86_64.rpm
> error: Failed dependencies:
> postgresql-server = 8.3.4 is needed by
> sepostgresql-8.3.4-2.1067.fc9.x86_64

It will be released soon, but not uploaded to Fedora 9 updates repository yet.
You can obtain the latest updates package from:
  http://koji.fedoraproject.org/koji/buildinfo?buildID=64273

In addition, it requires selinux-3.3.1-96.fc9 packages from:
  http://koji.fedoraproject.org/koji/buildinfo?buildID=64649
(But I don't know whether Dan want to push it to Fedora9 updates, or not.)

If you cannot wait for several days, plese obtain these packages by hand,
and apply them as follows:
  # rpm -Uvh sepostgresql-8.3.4-2.1067.fc9.x86_64.rpm   \
             postgresql-*8.3.4-1.fc9.x86_64.rpm         \
             selinux-policy-*3.3.1-96.fc9.noarch.rpm

BTW, there are no actual problem to mix postgresql-server-8.3.3 and
sepostgresql-8.3.4, because they has same major version number (8.3.x).
However, specfile of RPM does not allow to write a dependency to a part
of version number like "Requires: postgresql-server-8.3.*".
If someone knows the way to describe it cool, please tell me.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KJfQUv009662
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 14:41:26 -0500
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KJgfQc018198
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 19:42:42 GMT
Message-ID: <45DB4F07.9040607@trustedcs.com>
Date: Tue, 20 Feb 2007 13:41:59 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Klaus Weidner <klaus@atsec.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs - Resent with additional changes.
References: <45B8ACBF.8090201@redhat.com> <1171663101.20576.147.camel@sgc.columbia.tresys.com> <20070219031951.GA9827@w-m-p.com>
In-Reply-To: <20070219031951.GA9827@w-m-p.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Klaus Weidner wrote:
> On Fri, Feb 16, 2007 at 04:58:21PM -0500, Christopher J. PeBenito wrote:
>> On Thu, 2007-01-25 at 08:12 -0500, Daniel J Walsh wrote: 
>>> The MLS constraints are really screwed up.  Need to come to some kind of
>>> agreement between you, klaus and tcs.
>> I'm not familiar with the LSPP requirements, so its mainly up to Klaus
>> and the TCS guys to iron out what makes sense.
> 
> I haven't heard back from TCS about their opinion on this. I would
> suggest using the constraints as in Dan's policy (and as used in the
> RHEL5 rc) since those are designed to meet LSPP requirements.

We (TCS) are checking out the changes now.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

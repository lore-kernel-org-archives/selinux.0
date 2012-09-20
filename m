Message-ID: <1348145727.13835.5.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: seandroid 4.1.1
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexandra Test <testalexandrainstitute@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Thu, 20 Sep 2012 08:55:27 -0400
In-Reply-To: <CAKi3Puqw0r=d31S+8N5_=JDN4_bK3TH2EODogOfAxTFxvDsdpg@mail.gmail.com>
References: 
	<CAKi3PupyLSM2UktjTaS8U-WKmiRSpRdSJApn2vRETfEx83qNfg@mail.gmail.com>
	 <1347988424.31966.56.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3Puqw0r=d31S+8N5_=JDN4_bK3TH2EODogOfAxTFxvDsdpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-09-20 at 12:19 +0200, Alexandra Test wrote:
> I am sorry... it is working when the device is in permissive mode. 
> I really cannot understand the way to define the policies.
> For the wifi, for example, what do I suppose to do?
> 
> Thanks for your help

Follow the instructions on the wiki,
http://selinuxproject.org/page/SEAndroid#Getting_Started_with_SE_Android

In particular, capture the dmesg output to see the avc denials, and then
address those denials in your policy.  If you need help, post the avc
denials to the list and we can help you decipher them.

Boot it permissive, use the wifi, and then run adb shell su 0 dmesg |
grep avc, and post the result.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

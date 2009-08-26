Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7QG9MvN015460
	for <selinux@tycho.nsa.gov>; Wed, 26 Aug 2009 12:09:22 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7QGAYnN003911
	for <selinux@tycho.nsa.gov>; Wed, 26 Aug 2009 16:10:34 GMT
Message-ID: <4A955E29.4030703@manicmethod.com>
Date: Wed, 26 Aug 2009 12:09:13 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: "Anamitra Dutta Majumdar (anmajumd)" <anmajumd@cisco.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Adding AV assertion to selinux policy in RHEL5
References: <c63e41180908211425s3a66c448g1a81865c9f14bcc@mail.gmail.com>	<alpine.LRH.2.00.0908241149000.21562@tundra.namei.org> <4EF101F7236DB443A8FABF8164BFBD0C084801CF@xmb-sjc-223.amer.cisco.com> <4A952BA3.7050401@redhat.com>
In-Reply-To: <4A952BA3.7050401@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> On 08/25/2009 06:43 PM, Anamitra Dutta Majumdar (anmajumd) wrote:
>>
>>
>> We are looking for a well documented procedure to add AV assertion to
>> selinux policy on RHEL5.
>> So far all SELinux URL links refer to the fact that the AV assertion
>> needs to be added to assert.te file under $SELINUX_SRC folder.
>> This appears to be true only for RHEL4 not RHEL5 since there is no src
>> folder under /etc/selinux/targeted that contains the source policies in
>> RHEL5.
>> We have installed and built the selinux-policy-2.4.6-248.el5.src.rpm on
>> our RHEL5.4 box and we did not find any assert.te file.
>> Can someone help us with the exact method as to what needs to be done to
>> add an AV assertion rule to our policy.
>>
>> Thanks
>> Anamitra&  Radha
>>
>> --
>> fedora-selinux-list mailing list
>> fedora-selinux-list@redhat.com
>> https://www.redhat.com/mailman/listinfo/fedora-selinux-list
> questions like this should be asked on the SELinux<selinux@tycho.nsa.gov>  Mail List.
>
> I am not sure what you are asking for.


assert.te was the old place for neverallow rules in the example policy. In the 
reference policy neverallows are put in their appropriate place (you could grep 
for them in the source policy if you want to see).

However, with RHEL5 and greater distros you can just insert policy modules to 
add rules (including assertions). So just follow the RHEL5 instructions on 
adding a policy and you can add neverallows there.

You also need to enable assertion checking by adding this line to 
/etc/selinux/semanage.conf

expand-check = 1



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

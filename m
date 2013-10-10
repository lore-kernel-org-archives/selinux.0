Message-ID: <5256F9D4.6080901@tycho.nsa.gov>
Date: Thu, 10 Oct 2013 15:02:44 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Langland, Blake" <blangland@integrity-apps.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: MLS over loopback interface
References: <DA8D339A60101247B36E202899B1C93AA91986@CHUNEX01.integrity-apps.com>
In-Reply-To: <DA8D339A60101247B36E202899B1C93AA91986@CHUNEX01.integrity-apps.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/10/2013 01:12 PM, Langland, Blake wrote:
> All,
> 
> I have two web servers running on an SELinux machine, one running at s2 and one at s3. Both webservers have two webapps each that are attempting to communicate over the loopback interface. The communication is strictly s2 <-> s2 and s3 <-> s3. The problem I am having is setting the MLS level of the loopback interface. If I have it set below s3, the s3 webapps cannot send over the interface; If I have it set higher than s2, the s2 webapps cannot receive over the interface. Any suggestions?

Can you clarify exactly what avc denials you are getting?
Kernel version?
network_peer_controls enabled or disabled?

I don't see a mlstrustedobject-like exemption in the netif constraints
in refpolicy/policy/mls, so you can't just make the loopback netif type
a mlstrustedobject to exempt it.

I do however see that if you apply mls_net_write_within_range() to the
web server domains and if you put a range on the interface that covers
both levels, then it should pass the mls constraint in policy/mls.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

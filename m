From: Colin Powers <Colin.Powers@nexor.com>
To: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Subject: Restricting network communications of mounted filesystems
Date: Thu, 11 Aug 2016 14:31:03 +0000
Message-ID: <DB6PR0301MB25686B836200CDD7728F63829E1E0@DB6PR0301MB2568.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi folks,

I have a question about the way network communications of mounted filesystems works with SELinux. I wonder if anyone could provide some insight or a link to somewhere with more information.

So let's say I have a RHEL6 machine with two network interfaces and I want to be very selective about which process can access which network interface.

I can use iptables SECMARK to label all traffic on eth0 as my_eth0_packet_t and all traffic on eth1 as my_eth1_packet_t, then grant send/recv permissions appropriately.

But let's say I want to be able to mount CIFS shares only using eth0. Does iptables SECMARK work in this scenario?
If so, what process is actually doing the network communications - what SELinux type do I need to grant permission to send/recv my_eth0_packet_t?
If not - how does the network comms work in this scenario and what are the options to achieve my goal of limiting traffic to eth0?

Cheers
Colin Powers

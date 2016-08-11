Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Restricting network communications of mounted filesystems
From: Brandon Whalen <brandon@quarksecurity.com>
In-Reply-To: <DB6PR0301MB25686B836200CDD7728F63829E1E0@DB6PR0301MB2568.eurprd03.prod.outlook.com>
Date: Thu, 11 Aug 2016 11:23:20 -0400
Cc: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Message-Id: <CE8C089D-084A-402C-992C-96A696118818@quarksecurity.com>
References: <DB6PR0301MB25686B836200CDD7728F63829E1E0@DB6PR0301MB2568.eurprd03.prod.outlook.com>
To: Colin Powers <Colin.Powers@nexor.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


> On Aug 11, 2016, at 10:31 AM, Colin Powers <Colin.Powers@nexor.com> wrote:
> 
> Hi folks,
> 
> I have a question about the way network communications of mounted filesystems works with SELinux. I wonder if anyone could provide some insight or a link to somewhere with more information.

Look at section 2.21 of http://freecomputerbooks.com/books/The_SELinux_Notebook-4th_Edition.pdf. They cover the possibilities.

> 
> So let's say I have a RHEL6 machine with two network interfaces and I want to be very selective about which process can access which network interface.
> 
> I can use iptables SECMARK to label all traffic on eth0 as my_eth0_packet_t and all traffic on eth1 as my_eth1_packet_t, then grant send/recv permissions appropriately.
> 
> But let's say I want to be able to mount CIFS shares only using eth0. Does iptables SECMARK work in this scenario?
> If so, what process is actually doing the network communications - what SELinux type do I need to grant permission to send/recv my_eth0_packet_t?
> If not - how does the network comms work in this scenario and what are the options to achieve my goal of limiting traffic to eth0?
> 
> Cheers
> Colin Powers
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

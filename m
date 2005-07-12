Subject: Re: port and address caches
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joy Latten <latten@austin.ibm.com>
Cc: James Morris <jmorris@redhat.com>, SELinux@tycho.nsa.gov
In-Reply-To: <200507121746.j6CHkePX004477@faith.austin.ibm.com>
References: <200507121746.j6CHkePX004477@faith.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 14:06:28 -0400
Message-Id: <1121191588.16209.136.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-07-12 at 12:46 -0500, Joy Latten wrote:
> My colleague implemented port and ipaddress caches 
> in security_port_sid() and security_node_sid(). 
> I ran a few benchmark tests as indicated below. 
> The reaim benchmark is the only one that I
> know contains networking tests. The 16-way with the cache changes
> indicate some performance improvement. I am currently working 
> on a testcase that will somewhat exercise the use of ports and/or
> ipaddresses. Hopefully this will better indicate an improvement.

Hi,

Thanks for continuing to work on these patches.  Can you post or provide
a URL to a current version of the patches, against a recent upstream
kernel (e.g. 2.6.13-rc2-mm2)?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

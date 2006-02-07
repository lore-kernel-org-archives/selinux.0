Subject: Re: [redhat-lspp] Re: problem changing role.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Rodrigo Vivi <vivijim@br.ibm.com>
Cc: Kris Wilson <krisw@us.ibm.com>, glommer@br.ibm.com, redhat-lspp@redhat.com,
   dwalsh@redhat.com, Janak Desai <jdesai@us.ibm.com>, gcwilson@us.ibm.com,
   SELinux@tycho.nsa.gov, sgrubb@redhat.com
In-Reply-To: <200602071518.08728.vivijim@br.ibm.com>
References: <200602071452.18452.glommer@br.ibm.com>
	 <1139332211.2872.78.camel@moss-spartans.epoch.ncsc.mil>
	 <200602071518.08728.vivijim@br.ibm.com>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 12:31:34 -0500
Message-Id: <1139333494.2872.82.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-07 at 15:18 -0200, Rodrigo Vivi wrote:
> 2.6.15-1.1826.2.10_FC5
> 
> This is a FC5 test2 !

test2 was released 16 January, so it is unlikely to have this patch.
The current rawhide kernel (which will be in test3) does have it, but
you should really be using the LSPP kernel if you are doing LSPP-related
development and testing; it has a number of patches that are not in the
rawhide kernel because they are not upstream.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

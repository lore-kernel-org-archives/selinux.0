Subject: Re: file_type_auto_trans is not sufficient
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, Karl MacMillan <kmacmillan@tresys.com>,
   SELinux@tycho.nsa.gov, dwalsh@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050531212112.GF11815@lkcl.net>
References: <200505311412.j4VECK5F030983@gotham.columbia.tresys.com>
	 <1117551440.15167.25.camel@dhcp83-8.boston.redhat.com>
	 <20050531212112.GF11815@lkcl.net>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 07:21:53 -0400
Message-Id: <1117624913.32745.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-05-31 at 22:21 +0100, Luke Kenneth Casson Leighton wrote:
>  thinking "sideways" again - as i am wont to do.
> 
>  how about... a "sideways" solution to this - at the kernel level?
> 
>  a "silent" redirection / remount, on a per-application basis?
> 
>  no, i'm not joking.
> 
>  an option to "mount" which allows a specific APPLICATION (or group of
>  applications) to have any files/directories it creates/accesses in a
>  subdirectory ACTUALLY occur ELSEWHERE.

That's polyinstantiated directories.  See Chad Seller's postings.
However, it uses the kernel's existing support for per-process
namespaces and bind mounts rather than anything new in the kernel.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

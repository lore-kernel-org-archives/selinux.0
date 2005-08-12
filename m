Subject: Re: [PATCH] check ebitmap_write return value in policydb_write
From: Stephen Smalley <sds@tycho.nsa.gov>
To: serue@us.ibm.com
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20050812192854.GA7273@sergelap.austin.ibm.com>
References: <20050812192854.GA7273@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 12 Aug 2005 15:05:09 -0400
Message-Id: <1123873509.23483.95.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-08-12 at 14:28 -0500, serue@us.ibm.com wrote:
> The following patch fixes a bug found by Coverity in libsepol:
> 
> 	In policydb_write, the return value of ebitmap_write() is not
> 	checked.

Thanks, merged this one, and a corrected fix for the prior one.
Also fixed policydb_destroy to correctly handle the case where
type_attr_map/attr_type_map are NULL.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

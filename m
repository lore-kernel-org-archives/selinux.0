Subject: Re: [RFC & PATCH] inherited type definition.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <42412635.4030108@ak.jp.nec.com>
References: <42346C17.3090301@kaigai.gr.jp>
	 <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>
	 <4235C937.3030404@kaigai.gr.jp>
	 <1110824712.21378.196.camel@moss-spartans.epoch.ncsc.mil>
	 <4236CC03.5010104@kaigai.gr.jp>
	 <1110897751.25947.52.camel@moss-spartans.epoch.ncsc.mil>
	 <4237B950.2090604@ak.jp.nec.com>
	 <1110981928.4802.81.camel@moss-spartans.epoch.ncsc.mil>
	 <42394ECA.7010204@ak.jp.nec.com>
	 <1111067742.8664.31.camel@moss-spartans.epoch.ncsc.mil>
	 <42399AE4.5040508@kaigai.gr.jp>  <423E9CFF.3080808@kaigai.gr.jp>
	 <1111420782.13101.16.camel@moss-spartans.epoch.ncsc.mil>
	 <42412635.4030108@ak.jp.nec.com>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 08:56:57 -0500
Message-Id: <1111586217.21107.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-03-23 at 17:17 +0900, Kaigai Kohei wrote:
> The attached (3rd) patch implements TYPEEXTENDS statement in addition
> to the latest patch. Because TYPE ... EXTENDS statements can not handle
> forwarding loopup, TYPEEXTENDS statement is necessary to represent
> inheritance-relationship not to depend on the definition placement.
> 
> TYPEEXTENDS <type-name> EXTENDS <type/attr>, <type/attr>, ... ;
> 
> (*) <type-name> and <type/attr> must have been defined.
> This is almost the same as TYPEATTRIBUTE.
<snip>
> I tried to modify the Fedora-C3's strict policy for quick testing,
> and represent a unified file type of HTTPd/Samba/FTPd.
> 
> I intend to access /var/www/ftp via HTTP and FTP, /var/www/samba via HTTP and Samba.
> The following configuration was necessary for this purpose.
> 
> BTW, since any macros (such as apache) were so complex for me, the following
> configuration may be insufficiency in a precise sense.
> But it's easily understandable as a configuration sample for real application,
> I think.

Thanks for the additional patch and the example.  I'd like to encourage
people on the list who are actively writing policies to look at this
language extension and example and comment on whether they think it
would be helpful to them.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

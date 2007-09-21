Subject: Re: execmod permission
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD49A27D@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD49A27D@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Fri, 21 Sep 2007 08:53:26 -0400
Message-Id: <1190379206.17518.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-09-20 at 18:51 -0700, Clarkson, Mike R (US SSA) wrote:
> Can someone explain to me what this permission provides?
> 
> The explanation that I've seen is this: "Make executable a file mapping
> that has been modified (implied by a copy-on-write)"
> 
> I don't know what that means. The audit log is suggesting that I need to
> provide this permission for a shared library file. 

http://people.redhat.com/drepper/selinux-mem.html
http://people.redhat.com/drepper/textrelocs.html
http://docs.fedoraproject.org/selinux-faq-fc5/#faq-entry-unconfined_t

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

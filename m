Subject: Re: Problems with the MLS policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Salvo Giuffrida <giuffsalvo@hotmail.it>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <BAY114-F17D2660BD6C3262245D6CEAF360@phx.gbl>
References: <BAY114-F17D2660BD6C3262245D6CEAF360@phx.gbl>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 16:29:37 -0400
Message-Id: <1157660977.22197.136.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-07 at 19:59 +0200, Salvo Giuffrida wrote:
> I have Fedora Core 6 Test 1 (it's the VMware image found 
> here:http://www.thoughtpolice.co.uk/vmware/),

Do you mean test 2?

>  I installed the package 
> selinux-policy-mls-2.3.9-3. So, I now can switch to the "mls", in theory. 
> The problem is that there's no binary policy file in 
> /etc/selinux/mls/policy; so, I tough "I must compile it by myself", but in 
> /usr/devel/selinux/mls there aren't source files (there are only sources for 
> the targeted policy), only a lot of .pp files...
> Where can I find those sources, or the rpm with them? And, where can I find 
> more information to the classification system used (I didn't understand what 
> those "SystemLow-SystemHigh" stand for)?

If you have installed the selinux-policy-mls rpm successfully, then
there should be a binary policy file under /etc/selinux/mls/policy/.  Do
you have a /etc/selinux/mls/modules/active directory?  If so, does
semodule -B generate a binary policy file for you?
  
The devel files are for building policy modules, not for rebuilding the
base policy.  The full policy sources are available in the
selinux-policy .src.rpm file, but you don't need that unless you are
making changes to the policy that can't be expressed as a module or via
semanage.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

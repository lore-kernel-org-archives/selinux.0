Message-ID: <45008570.8000209@hp.com>
Date: Thu, 07 Sep 2006 16:47:44 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Salvo Giuffrida <giuffsalvo@hotmail.it>, selinux@tycho.nsa.gov
Subject: Re: Problems with the MLS policy
References: <BAY114-F17D2660BD6C3262245D6CEAF360@phx.gbl> <1157660977.22197.136.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1157660977.22197.136.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-09-07 at 19:59 +0200, Salvo Giuffrida wrote:
> 
>>I have Fedora Core 6 Test 1 (it's the VMware image found 
>>here:http://www.thoughtpolice.co.uk/vmware/),
> 
> 
> Do you mean test 2?
> 
> 
>> I installed the package 
>>selinux-policy-mls-2.3.9-3. So, I now can switch to the "mls", in theory. 
>>The problem is that there's no binary policy file in 
>>/etc/selinux/mls/policy; so, I tough "I must compile it by myself", but in 
>>/usr/devel/selinux/mls there aren't source files (there are only sources for 
>>the targeted policy), only a lot of .pp files...
>>Where can I find those sources, or the rpm with them? And, where can I find 
>>more information to the classification system used (I didn't understand what 
>>those "SystemLow-SystemHigh" stand for)?
> 
> 
> If you have installed the selinux-policy-mls rpm successfully, then
> there should be a binary policy file under /etc/selinux/mls/policy/.  

I've saw the same problem recently when I installed the mls policy on
my FC6T2 system using yum.  The rpm seemed to install but got non-fatal
errors which left it without a binary policy file and a few other
important files.  I had to remove the rpm and update all the various
selinux rpms to get the mls policy to install correctly.

I believe Dan has fixed some dependency problems with the rpms to solve
this problem.

-- ljk



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l29FPmf4024995
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 10:25:48 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l29FPlms022957
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 15:25:48 GMT
Received: by py-out-1112.google.com with SMTP id a78so321709pyh
        for <selinux@tycho.nsa.gov>; Fri, 09 Mar 2007 07:25:45 -0800 (PST)
Message-ID: <45F17C70.70707@kaigai.gr.jp>
Date: Sat, 10 Mar 2007 00:25:36 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
References: <45EC0D21.2070706@kaigai.gr.jp>  <45EC2C10.6050603@kaigai.gr.jp>	 <1173284267.10747.9.camel@sgc>  <45F010A4.4020201@kaigai.gr.jp>	 <1173360830.10467.29.camel@moss-spartans.epoch.ncsc.mil>	 <45F022A0.3020105@kaigai.gr.jp>	 <1173366058.10467.67.camel@moss-spartans.epoch.ncsc.mil>	 <45F02A09.5060301@tresys.com>  <45F02A80.5050708@tresys.com>	 <1173367847.10467.72.camel@moss-spartans.epoch.ncsc.mil>	 <45F038C5.4070003@tycho.nsa.gov> <1173385436.3241.54.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1173385436.3241.54.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-03-08 at 11:24 -0500, Eamon Walsh wrote:
>> Stephen Smalley wrote:
>>
>>> There are already string_to_security_class() and string_to_av_perm()
>>> functions provided by libselinux, although they should likely have
>>> properly namespaced versions (selinux_ prefix).
>> If we're talking about the API in this area: I had a request for 
>> security_class_to_string and av_perm_to_string functions, I believe from 
>> KaiGai.  The patch in the below e-mail adds them; this could be applied 
>> as an independent patch.
>>
>> http://marc.theaimsgroup.com/?l=selinux&m=116486019626891&w=2
> 
> Ok, so we could:
> - introduce new versions of the existing string_to_* functions with a
> security_ or selinux_ prefix for namespace cleanliness,
> - merge that patch, using the same convention for naming (either as is
> with security_ or replacing with selinux_,
> - have KaiGai rewrite his code to use these functions to map class and
> permission strings to policy values during startup of SEPostgreSQL,
> generating lookup tables for later use by the actual permission checks
> (where the lookup tables would map internal indices private to
> SEPostgreSQL to the policy-defined values obtained from libselinux).
> The tables would need to be revalidated and potentially refreshed upon a
> policy reload, which could be done from an AVC callback.
> 
> Then SEPostgreSQL no longer needs to be compile-time bound to specific
> policy values for its classes and permissions.

I also think it's an excellent idea!
I'll rewrite a part of implementation to generate classes/access vectors
lookup table and to use them.


> Same could be done for XSELinux, right?
> 
> Then when we have the dynamic discovery mechanism implemented, it can
> just be used by those libselinux functions internally, with no further
> change to the object managers.
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

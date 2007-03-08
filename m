Message-ID: <45F038C5.4070003@tycho.nsa.gov>
Date: Thu, 08 Mar 2007 11:24:37 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
References: <45EC0D21.2070706@kaigai.gr.jp>  <45EC2C10.6050603@kaigai.gr.jp>	 <1173284267.10747.9.camel@sgc>  <45F010A4.4020201@kaigai.gr.jp>	 <1173360830.10467.29.camel@moss-spartans.epoch.ncsc.mil>	 <45F022A0.3020105@kaigai.gr.jp>	 <1173366058.10467.67.camel@moss-spartans.epoch.ncsc.mil>	 <45F02A09.5060301@tresys.com>  <45F02A80.5050708@tresys.com> <1173367847.10467.72.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1173367847.10467.72.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

> There are already string_to_security_class() and string_to_av_perm()
> functions provided by libselinux, although they should likely have
> properly namespaced versions (selinux_ prefix).

If we're talking about the API in this area: I had a request for 
security_class_to_string and av_perm_to_string functions, I believe from 
KaiGai.  The patch in the below e-mail adds them; this could be applied 
as an independent patch.

http://marc.theaimsgroup.com/?l=selinux&m=116486019626891&w=2

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

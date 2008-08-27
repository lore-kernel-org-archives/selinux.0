Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7R5aADx030524
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 01:36:10 -0400
Received: from wf-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7R5ZfUc017737
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 05:35:41 GMT
Received: by wf-out-1314.google.com with SMTP id 28so2547666wff.30
        for <selinux@tycho.nsa.gov>; Tue, 26 Aug 2008 22:36:09 -0700 (PDT)
Message-ID: <7b740b700808262236m2b8a01g659338d003fe4569@mail.gmail.com>
Date: Wed, 27 Aug 2008 10:36:09 +0500
From: Shaz <shazalive@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: semodule -i not working
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1219749047.2721.197.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <7b740b700808260251l55f56127n8668e777dacbe26f@mail.gmail.com>
	 <1219749047.2721.197.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 26, 2008 at 4:10 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Tue, 2008-08-26 at 14:51 +0500, Shaz wrote:
>> I was trying to load the following module:
>> ---------------------------------
>>      module spamd 1.0;
>>
>>      require {
>>      role object_r;
>>      role system_r;
>>
>>      class tcp_socket name_connect;
>>
>>      type ldap_port_t;
>>      type spamd_t;
>>      };
>>
>>      allow spamd_t ldap_port_t:tcp_socket name_connect;
>> --------------------------------
>>
>> and I got the following error:
>>
>>      [root@develap lpm]# semodule -i spamd.pp
>>      libsepol.module_package_read_offsets: wrong magic number for
>> module package:  expected 4185718671, got 1969516397
>>      libsemanage.parse_module_headers: Could not parse module data.
>>      semodule:  Failed on spamd.pp!
>>
>> How do I understand the problem and what can be the possible solution?
>
> How did you build spamd.pp?  And what versions of libsepol, libsemanage,
> and policycoreutils are you using?
>
Ok. I did not compile it :o). Just copied it from
http://fedoraproject.org/wiki/SELinux/LoadableModules/Audit2allow and
did semodule -i.

Thanks.
> --
> Stephen Smalley
> National Security Agency
>
>



-- 
Shaz

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

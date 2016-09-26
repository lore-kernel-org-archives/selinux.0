Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8QDdCSX019565
 for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2016 09:39:12 -0400
Subject: Re: [PATCH 1/1] genhomedircon: support policies using RBACSEP
To: selinux@tycho.nsa.gov
References: <cover.1474639773.git.gary.tierney@gmx.com>
 <1062ebe32922aec79a0232acfdd0005e9ce124da.1474639773.git.gary.tierney@gmx.com>
 <20160923154356.GA8039@workstation.fluency.net.uk>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fc6a4dbc-8973-4629-9224-33a855d34eec@tycho.nsa.gov>
Date: Mon, 26 Sep 2016 09:41:34 -0400
MIME-Version: 1.0
In-Reply-To: <20160923154356.GA8039@workstation.fluency.net.uk>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/23/2016 11:43 AM, Gary Tierney wrote:
> On Fri, Sep 23, 2016 at 03:28:44PM +0100, Gary Tierney wrote:
>> Introduces support for generating homedir/user contexts for
>> policies that implement RBACSEP.  The support works by taking the
>> prefix of a logins seuser and replacing the role field in their
>> context specifications with the prefix.  A new option
>> "genhomedircon-rbacsep" was added to /etc/selinux/semanage.conf
>> to allow toggling this behavior.
>> 
>> The user prefix can be set from both standard kernel policy and
>> CIL:
>> 
>> CIL: (user user_u) (role user_r) (userrole user_u user_r) 
>> (userprefix user_u user_r)
>> 
>> kernel policy language: role user_r; user user_u roles { user_r }
>> prefix user_r;
>> 
>> Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
<snip>
> perfinion at #selinux on freenode IRC suggested that the
> genhomedircon-rbacsep option should be dropped, and instead a
> RBACSEP context should be chosen first in all cases.  If validation
> of this context fails, then it should fall back to whatever the
> existing role is.
> 
> Anyone have thoughts on this?  This seems to me like a much better
> solution than using a new genhomedircon-rbacsep option, but the
> problem of using "userprefix" still remains.

Does a valid RBACSEP context necessarily mean that RBACSEP was
desired/intended? (likely: otherwise the role-type association
wouldn't be authorized)

Does an invalid RBACSEP context necessarily mean that RBACSEP was not
desired/intended? (unclear: what if we just forgot the role-type
statement for a particular type)

Also, we base it on context validation, then it could differ for
different entries - some could end up with RBACSEP applied and others not.

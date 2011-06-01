Message-ID: <4DE60BA7.8070505@windriver.com>
Date: Wed, 1 Jun 2011 17:51:35 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: <qingtao.cao@windriver.com>
MIME-Version: 1.0
CC: <cpebenito@tresys.com>, <sds@tycho.nsa.gov>, <method@manicmethod.com>,
        <jmorris@namei.org>, <eparis@parisplace.org>, <selinux@tycho.nsa.gov>
Subject: Re: [v2 PATCH 6/6] Support adding one role attribute into another
References: <1306918677-3657-1-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1306918677-3657-1-git-send-email-qingtao.cao@windriver.com>
Content-Type: multipart/mixed;
	boundary="------------010509050008010403020109"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--------------010509050008010403020109
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, this should be the 0/6 email before all the following patches, 
the real 6/6 patch is attached.

Thanks,
Harry

On 06/01/2011 04:57 PM, Harry Ciao wrote:
>
> Hi,
>
> This is the v2 patches to add role attribute support.
>
> So far the only change from v1 is to introduce a new "attribute_role"
> statement to declare a role attribute, rather than overloading the
> "attribute" statement that aims at declaring a type attribute.
>
> Other than that, also updated the patch header for the 6/6 patch to
> support the "nesting" of role attributes, that since role_copy_callback()
> would copy any symtab[SYM_ROLES] table(no matter if it's a module's global
> p_roles table or from an avrule_decl_t) into base.p_roles table, it would
> be enough to traverse base.p_roles table to expand sub-attribute's roles
> ebitmap into that of the parent.
>
> Thanks a lot for all your time to review these patches!
>
> Best regards,
> Harry
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

--------------010509050008010403020109
Content-Type: text/x-patch;
	name="0006-Support-adding-one-role-attribute-into-another.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0006-Support-adding-one-role-attribute-into-another.patch"


--------------010509050008010403020109--

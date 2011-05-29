Message-ID: <4DE2CF62.4060909@manicmethod.com>
Date: Sun, 29 May 2011 18:57:38 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Harry Ciao <qingtao.cao@windriver.com>
CC: cpebenito@tresys.com, sds@tycho.nsa.gov, jmorris@namei.org,
        eparis@parisplace.org, selinux@tycho.nsa.gov
Subject: Re: [v1 PATCH 1/6] Add role attribute support when compiling modules.
References: <1306643819-30374-1-git-send-email-qingtao.cao@windriver.com> <1306643819-30374-2-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1306643819-30374-2-git-send-email-qingtao.cao@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Harry Ciao wrote:
> 1. Add a uint32_t "flavor" field and an ebitmap "roles" to the
> role_datum_t structure;
>
> 2. Modify the attribute declaration rule to add support to declare
> role attribute as well as type attribute;

Lets just use a different token to declare role attributes and use 
separate parser functions. I strongly dislike the char *kind in 
define_attrib(). Overloading tokens has caused much pain in the past.

>
> 3. Modify declare_role() to setup role_datum_t.flavor according
> to the isattr argument;
>
> 4. Add a new roleattribute rule and its handler, which will record
> the regular role's (policy value - 1) into the role attribute's
> role_datum_t.roles ebitmap;
>
> 5. Modify the syntax for the role_types rule only to define the
> role-type associations;
>
> 6. Add a new role_attr rule to support the declaration of a single
> role, and the role attribute that the role belongs to;
>
> 7. Check if the new_role used in role transition is a regular role;
>
> 8. Make the role-types rule no longer used to declare a regular role
> but solely aimed for declaring role-types associations;
>
> FIXME:
> How to pass a second argument to require_attribute(), to indicate
> if the attribute is of role or type ?

My suggestion on #2 should resolve this.

I'll look at the other patches soon.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

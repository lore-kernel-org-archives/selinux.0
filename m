Date: Mon, 10 Jun 2002 12:33:07 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: =?iso-8859-1?Q?Vanuxem_gr=E9gory?= <gvanuxem@club-internet.fr>
cc: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: BUGS for mlstrusted*
In-Reply-To: <ADEEIKPBIEHIINPOFGAOKEFDCDAA.gvanuxem@club-internet.fr>
Message-ID: <Pine.GSO.4.33.0206101218400.13767-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 7 Jun 2002, [iso-8859-1] Vanuxem grégory wrote:

>  In the configurations files, if
>  we make typo errors like "mlstrustedreeeder",
>  the checkpolicy compile and load the new policydb !!!

That isn't a bug, merely a side effect of using the existing type
attribute facility to imply MLS trust characteristics.  Aside from the MLS
policy, type attributes have no implicit meaning (i.e. their meaning is
entirely defined by how they are used in the TE configuration), and type
attributes are implicitly declared when they are used in a type
declaration.  Hence, from the policy compiler's point of view,
mlstrustedreeeder is a perfectly legitimate type attribute that has no
relationship to the MLS policy.

If you want the compiler to catch such errors, then the language would
need to be changed to require that type attributes be explicitly declared.
This would not only catch errors with typos in the MLS-relevant type
attributes but also in any type attribute.  David Wheeler previously
suggested adding such declarations in order to permit such checking.  We
could do this, at the cost of breaking existing configurations.

>  Another thing, the extended socket call don't work
>  with ipv6

Yes.  But the labeled networking support is also currently limited to
ipv4.  And so are the LSM networking hooks.  ipv6 support has not yet been
a priority.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

Subject: Re: There is a bug in checkmodule that is driving me nuts
From: Karl MacMillan <kmacmill@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46A11983.5090405@redhat.com>
References: <46A11983.5090405@redhat.com>
Content-Type: text/plain
Date: Fri, 20 Jul 2007 18:28:24 -0400
Message-Id: <1184970504.14677.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2007-07-20 at 16:22 -0400, Daniel J Walsh wrote:
> The compiler is mistakenly seeing a
> 
> gen_requires {
>        type  xguest_gnome_home_t;
> }
> 
> As a redefinition of the type
> 
>  /usr/bin/checkmodule -M -m guest.tmp -o guest.mod/usr/bin/checkmodule:  
> loading policy configuration from guest.tmp
> policy/modules/users/guest.te:4:ERROR 'duplicate declaration of 
> type/attribute' at token ';' on line 55020:
>         type xguest_gnome_home_t;
> #line 4
> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> 
> The problem is the gen_requires happens before the declaration.
> 
> The type is being declared in  a template file.

For better or discarding of requires upon hitting a declaration isn't
like to be fixed (when the require is first).

I have an alternative suggestion - remove all of the requires from the
policy and use an sepolgen-based pre-processor to add them back in until
the policyrep work is done. That will ease the migration and can be done
far more easily than fixing the current compiler.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

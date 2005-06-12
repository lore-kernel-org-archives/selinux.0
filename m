Message-ID: <20050612021611.94597.qmail@web51501.mail.yahoo.com>
Date: Sat, 11 Jun 2005 19:16:11 -0700 (PDT)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: Question about integration of IPsec with SELinux? 
To: Casey Schaufler <casey@schaufler-ca.com>, Valdis.Kletnieks@vt.edu
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050611194952.24393.qmail@web31609.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 11 Jun 2005 at 12:49, Casey Schaufler wrote:

> --- Valdis.Kletnieks@vt.edu wrote:
>
>> (I'm guessing that OpenSSH was one of the "other
>> protocols" Casey mentioned -
>> it's *very* useful in it's problem space, but isn't
>> the best choice for *this*
>> problem (building an MLS cluster)...)
>
> The higher level the protocol the fewer system
> services (e.g. NFS) that you can use it for.

If we use OpenSSH, Does it mean that we should send
the data and its security attribute (e.g. sensitivity
and clearance information of the data) together within
a packet? 
and Is there any other way to send security attribute
first and then the date (just like in IPsec case)
except using IPsec?

Thanks,

Best Regards,
Park Lee

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

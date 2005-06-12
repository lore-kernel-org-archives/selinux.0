Message-ID: <20050612170212.40575.qmail@web51506.mail.yahoo.com>
Date: Sun, 12 Jun 2005 10:02:12 -0700 (PDT)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: Question about integration of IPsec with SELinux?
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Valdis.Kletnieks@vt.edu, Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   James Morris <jmorris@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050611172750.41238.qmail@web31601.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
First, I'm sorry for my missending a blank letter just
now.

On Sat, 11 Jun 2005 at 10:27, Casey Schaufler wrote:
> --- Park Lee <parklee_sel@yahoo.com> wrote:
>
>> there is an item which says:"Integrate IPSEC with
>> network mandatory controls".
>> I know that it means:"integration of SELinux and
>> IPSEC
>> for the purpose of labeling and protecting network
>> packets in accordance with security policy".
>> 
>>      But, Would you please tell me :
>> Is there any motivation of doing it? What is the
>> significance of doing it? Where to use it? 
>> and Is there a scene/scenario for it?
>
> IPSEC is the forward looking mechanism for
> passing process attributes between machines.
> Without it (or one of the protocols that
> preceeded it but have fallen from favor)
> there is no way to make access control decisions
> on network based communications. You can't
> do an MLS cluster, for example, without passing
> sensitivity and clearance information among
> the machines involved.

But, when we "Integrate IPSEC with network mandatory
controls", we only label and protect _network_
_packets_, How can we control _processes_ in network
circumstance?

and, Can I view what you wrote as a application of
"labeled networking"
which is mentioned by James Morris in
http://www.linuxjournal.com/article/7764 ?
then, What is the purpose of a "labeled networking"?


Thanks a lot. 





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

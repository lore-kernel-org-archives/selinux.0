Message-ID: <3F4A1B8E.9070901@tresys.com>
Date: Mon, 25 Aug 2003 10:22:06 -0400
From: David Caplan <dac@tresys.com>
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: questions
References: <1061676714.1648.281.camel@kusturica>
In-Reply-To: <1061676714.1648.281.camel@kusturica>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Magosányi Árpád wrote:
> 
> -What tools and techniques exist for analysing the policy?
>  For example how can I list domains besides using grep and friends
>  on the policy file?

You can check out our tools (http://www.tresys.com/setools), 
specifically apol for policy analysis.  Apol has many features which can 
help you break down the policy components as well as search through the 
rules with filters on object types/classes/permissions/attributes/etc.

David

___________________________
David Caplan
Tresys Technology, LLC.
dac@tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

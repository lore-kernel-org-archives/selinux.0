Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5TJKhnT010347
	for <selinux@tycho.nsa.gov>; Fri, 29 Jun 2007 15:20:43 -0400
Received: from [66.135.97.2] (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5TJKfHt021915
	for <selinux@tycho.nsa.gov>; Fri, 29 Jun 2007 19:20:42 GMT
Message-ID: <46855B72.7050502@manicmethod.com>
Date: Fri, 29 Jun 2007 15:20:18 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Initial policyrep patch v2
References: <f71c0f396608e6e362ed.1183040619@localhost.localdomain>
In-Reply-To: <f71c0f396608e6e362ed.1183040619@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> +	
> +	AVRule* define_avrule(AVRule::Type type, IdSet* src_types,
> +			      IdSet* tgt_types, IdSet* classes,
> +			      IdSet* perms, Parser& driver)
> +	{
> +		AVRule* x = new AVRule(type);
> +		
> +		x->src_types().ids().insert(src_types->ids().begin(), src_types->ids().end());
> +		x->src_types().set_compl(src_types->get_compl());
> +		delete src_types;
> +
>   
I don't see - (subtraction) handling here, also compliments are not 
allowed in type sets for any rules except neverallows (which also allows 
*), also how do you handle * in permissions?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

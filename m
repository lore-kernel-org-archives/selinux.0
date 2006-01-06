Message-ID: <43BDE05A.40501@tresys.com>
Date: Thu, 05 Jan 2006 22:13:30 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEPOL][SEMANAGE] Compare2 functions
References: <43BDBE46.6050504@cornell.edu>
In-Reply-To: <43BDBE46.6050504@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> Hi, the following patch adds compare2 functions, which compare record 
> <--> record, instead of record <--> key.
> Yes, the name is rather annoying. I wanted compare for records, and 
> compare_key for the key, but that would be an api change. This seems 
> like the next best thing.

it may be ok to break the API for these, AFAIK there are no external 
users of these functions, not even ours and all the function tables are 
internal.
> 
> The compare2 function is necessary, because otherwise to compare two 
> records you need to extract a key, which does a malloc, which is 
> inefficient, and a pain. More importantly, it may fail, so it takes a 
> handle, and qsort() can't pass in a void* arg to comparator, so it can't 

are you sure you want to use qsort? It wasn't suitable for matchpathcon 
because it is an unstable sort.

> pass a handle (unless you wrap each port in an additional structure or 
> something crazy like that).
> 
> Sorting is necessary to check for overlapping port ranges in a 
> reasonable amount of time. It is also a prerequisite for a join 
> operation (which I am still not clear how to do properly without adding 
> lots of complexity).
<snip>
> diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/src/port_record.c new/libsepol/src/port_record.c
> --- old/libsepol/src/port_record.c	2006-01-05 14:38:29.000000000 -0500
> +++ new/libsepol/src/port_record.c	2006-01-05 19:24:43.000000000 -0500
> @@ -109,6 +109,34 @@ int sepol_port_compare(
>  		return 1;
>  }
>  
> +int sepol_port_compare2(
> +	const sepol_port_t* port,
> +	const sepol_port_t* port2) {
> +
> +	if ((port->low == port2->low) &&
> +	    (port->high == port2->high) &&
> +	    (port->proto == port2->proto))
> +		return 0;
> +
> +	if (port->low < port2->low)
> +		return -1;
> +
> +	else if (port2->low < port->low)
> +		return 1;
> +
> +	else if (port->high < port2->high)
> +		return -1;
> +
> +	else if (port2->high < port->high)
> +		return 1;
> +
> +	else if (port->proto < port2->proto)
> +		return -1;
> +
> +	else
> +		return 1;
> +}
> +

I don't think I understand this sort logic, particularly the port->proto 
   < port2->proto part

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

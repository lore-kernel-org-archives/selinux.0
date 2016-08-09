Subject: Re: [PATCH] libsepol: fix memory leak in expand.c
To: "Roberts, William C" <william.c.roberts@intel.com>,
 "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>,
 "'seandroid-list@tycho.nsa.gov'" <seandroid-list@tycho.nsa.gov>,
 "'sds@tycho.nsa.gov'" <sds@tycho.nsa.gov>
References: <1470677301-20065-1-git-send-email-william.c.roberts@intel.com>
 <476DC76E7D1DF2438D32BFADF679FC56012805C4@ORSMSX103.amr.corp.intel.com>
 <476DC76E7D1DF2438D32BFADF679FC56012812D9@ORSMSX103.amr.corp.intel.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <a6d7d4f7-98fe-ef24-1648-1ebc20fbaf11@tycho.nsa.gov>
Date: Tue, 9 Aug 2016 16:26:35 -0400
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC56012812D9@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/09/2016 12:12 PM, Roberts, William C wrote:
> <snip>
>>>
>>> -      out:
>>> +	  out:
>>> +	rc = 0;
>>>
>>> -	ebitmap_destroy(&types);
>>> +	  err_neg:
>>>  	ebitmap_destroy(&neg_types);
>>> +	  err_types:
>>> +	ebitmap_destroy(&types);
>>>
>>> -	return 0;
>>> +	return rc;
>>>  }
>
> I just noticed the indenting on the label changed, I went through the
> File and it has:
> 1. labels with 7 leading spaces
> 2. labels left justified
>
> Which one is the way you want them, left justified?

I think the left justified ones are from me, your patches matches with the 
common usage, so I applied it.

Thanks,
Jim

>
> Bill
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency

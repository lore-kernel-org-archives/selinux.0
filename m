Message-ID: <4B97D2D0.3010507@tycho.nsa.gov>
Date: Wed, 10 Mar 2010 12:11:44 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
CC: Andy Warner <warner@rubix.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: selabel_*() support for database objects
References: <4B050008.3010201@ak.jp.nec.com> <4B0757F5.5080902@tycho.nsa.gov> <4B07F64B.1070407@kaigai.gr.jp> <4B0DBDF2.5050601@ak.jp.nec.com> <4B14396A.9000207@tycho.nsa.gov> <4B8C7D8C.9060803@ak.jp.nec.com> <4B9584A3.1070603@tycho.nsa.gov> <4B9598F1.50309@ak.jp.nec.com> <4B95A2D2.3080101@tycho.nsa.gov> <4B95A780.8050300@ak.jp.nec.com> <4B96AAA7.5090909@tycho.nsa.gov> <4B96C8CA.1090301@kaigai.gr.jp>
In-Reply-To: <4B96C8CA.1090301@kaigai.gr.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/09/2010 05:16 PM, KaiGai Kohei wrote:
> (2010/03/10 5:08), Eamon Walsh wrote:
>   
>> What is the meaning of the fourth "temp" argument here. Aren't lines
>> only supposed to have three entries? Please remove this if it is not needed.
>>     
> If the line has four or more elements, we want to raise an error, rather than
> ignoring it.
> If here is not the fourth %as, sscanf() does not return 4, does it?
>
> Thanks,
>   


OK, that makes sense.

I don't see any other issues with the patches. Unless Andy has any
concerns, I will push them later today or tomorrow.


-- 

Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

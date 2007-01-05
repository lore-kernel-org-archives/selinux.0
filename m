Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l05JYxDb000415
	for <selinux@tycho.nsa.gov>; Fri, 5 Jan 2007 14:35:00 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l05JZiY9007923
	for <selinux@tycho.nsa.gov>; Fri, 5 Jan 2007 19:35:45 GMT
Message-ID: <459EA887.7070806@tresys.com>
Date: Fri, 05 Jan 2007 14:35:35 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] check for handle creation failures in seobject
References: <459E7C60.8070308@mentalrootkit.com> <459E8672.3060708@mentalrootkit.com>
In-Reply-To: <459E8672.3060708@mentalrootkit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> Karl MacMillan wrote:
>> seobject.py assumes that handle creation always succeeds, though this 
>> is not always the case. This patch checks for that failure.
>>
>> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
>>
>
> Another try without line wrapping and with tabs instead of spaces.
>
>
> diff -r 5e7683c788a4 policycoreutils/semanage/seobject.py
> --- a/policycoreutils/semanage/seobject.py    Fri Jan 05 12:05:19 2007 
> -0500
> +++ b/policycoreutils/semanage/seobject.py    Fri Jan 05 12:08:34 2007 
> -0500
> @@ -208,6 +208,9 @@ class semanageRecords:
>  class semanageRecords:
>      def __init__(self):
>          self.sh = semanage_handle_create()
> +        if not self.sh:
> +               raise ValueError(_("Could not create semanage handle"))
> +       
>          self.semanaged = semanage_is_managed(self.sh)
>
>          if not self.semanaged:
>
Acked-By: Joshua Brindle <jbrindle@tresys.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

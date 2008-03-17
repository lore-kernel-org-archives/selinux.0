Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2HNGuLm032676
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2008 19:16:56 -0400
Received: from wf-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2HNGtNE021661
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2008 23:16:56 GMT
Received: by wf-out-1314.google.com with SMTP id 28so6059465wfc.30
        for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2008 16:16:55 -0700 (PDT)
Message-ID: <dd18b0c30803171616l371dd04eq49281a9fd33e5e9f@mail.gmail.com>
Date: Mon, 17 Mar 2008 23:16:55 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
Subject: Re: pam.d
Cc: selinux@tycho.nsa.gov
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D0472B4F6@de01exm68.ds.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30803141633j6a57b32q5cd25ae8e16b6e54@mail.gmail.com>
	 <D06FE0A2807BC145B0D38744789D4F5D0472B4F6@de01exm68.ds.mot.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello;  Hasan,
 Sorry there hasn't been a solution; hopefully somebody who has better
experience diagnosing problems can help you.
regards; (Does you're system login with SELinux disabled?)

-- 
    Justin P. Mattock





On Mon, Mar 17, 2008 at 10:26 PM, Hasan Rezaul-CHR010
<CHR010@motorola.com> wrote:
>
>
> Thanks Justin,
>
> I tried adding/modifying the lines you mentioned below... but it didnt get
> rid of my problem  :-(
>
> Thanks anayway.. and please let me know if you have any other suggestions.
>
> - Rezaul.
>
>  ________________________________
>  From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Justin Mattock
> Sent: Friday, March 14, 2008 6:34 PM
> To: selinux@tycho.nsa.gov
> Subject: pam.d
>
>
> Hello;
>  try putting: session required pam_selinux.so multiple in /etc/pam.d/login
> for namespace I have the folowing: session required pam_namespace.so
> multiple
> hope this helps with logging in.
> --
> Justin P. Mattock



-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

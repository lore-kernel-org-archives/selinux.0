Message-ID: <5D201EB6E3041946BC4F8F6A14296132607EEB@svnt4-5.inepar.com.br>
From: "Luis Fernando C. Talora" <luis.talora@iesa.com.br>
To: "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>
Cc: " (SELinux@tycho.nsa.gov)" <SELinux@tycho.nsa.gov>
Subject: RES: Problem with SELinux and Squid+Winbind+Samba
Date: Wed, 8 Dec 2004 08:36:12 -0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

That´s the problem: I have no idea of how to build policies for SELinux...
Is there a way to remove SELinux features without reinstaling the OS from
the scratch? Or (maybe it´s better) could you please tell me where to find
some documentation about SELinux? Some tips on how to build the policies
would be nice, too... :) 

I´m using Fedora Core 3.

Thank you very much!

Regards,

_____________________
Luis Fernando C. Talora


-----Mensagem original-----
De: Luke Kenneth Casson Leighton [mailto:lkcl@lkcl.net] 
Enviada em: terça-feira, 7 de dezembro de 2004 18:41
Para: Luis Fernando C. Talora
Cc: (SELinux@tycho.nsa.gov)
Assunto: Re: Problem with SELinux and Squid+Winbind+Samba

On Tue, Dec 07, 2004 at 09:19:14AM -0200, Luis Fernando C. Talora wrote:
> Fellows,
>  
> I?m trying to put a server running Squid with Microsoft Windows Active 
> Directory integrated authentication (using Samba 3 and Winbind). When 
> I start the squid service, I get the following message (it repeats 
> itself many
> times):
>  
> Dec  7 08:48:56 svux8-250 kernel: audit(1102416536.028:0): avc:  
> denied  { getattr } for  pid=3825 exe=/usr/lib/squid/wb_ntlmauth 
> path=/var/run/winbindd/pipe dev=hda7 ino=627398 
> scontext=root:system_r:squid_t tcontext=root:object_r:var_run_t 
> tclass=sock_file
  
> Since I?m new in SELinux, I have no idea how to solve this. Could 
> someone give some help?
 
  ah.   there's quite a lot involved!

  the first thing is, ideally, to write a separate policy for winbindd,
  esp. making /var/run/winbindd have its own file context.

  then you can grant wb_ntlmmauth (or squid_t) the right to access
  /var/run/winbindd/pipe.

 ... anyone got any opinions as to whether winbind should be creating a
socket in /var/run?  is that FHS compliant?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with the words "unsubscribe selinux" without quotes as the message.
===================================================================
Esta mensagem pode conter informação confidencial e/ou privilegiada.
Se você não for o destinatário ou a pessoa autorizada a receber esta 
mensagem, não deverá utilizar, copiar, alterar, divulgar a informação 
nela contida ou tomar qualquer ação baseada nessas informações. Se 
você recebeu esta mensagem por engano, por favor avise imediatamente 
o remetente, respondendo o e-mail e em seguida apague-o.Agradecemos 
sua cooperação. 

This message may contain confidential and/or privileged information. 
If you are not the addressee or authorized to receive this for the 
addressee, you must not use, copy, disclose, change, take any action 
based on this message or any information herein. If you have received
this message in error, please advise the sender immediately by reply 
e-mail and delete this message. Thank you for your cooperation.
===================================================================


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

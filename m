Message-ID: <5D201EB6E3041946BC4F8F6A14296132607EF0@svnt4-5.inepar.com.br>
From: "Luis Fernando C. Talora" <luis.talora@iesa.com.br>
To: "'Colin Walters'" <walters@verbum.org>,
   "Luis Fernando C. Talora" <luis.talora@iesa.com.br>
Cc: "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "(SELinux@tycho.nsa.gov)" <SELinux@tycho.nsa.gov>
Subject: RES: RES: Problem with SELinux and Squid+Winbind+Samba
Date: Wed, 8 Dec 2004 15:47:22 -0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you all! I´ll make a few tests and will let you know.

Regards,

Luís F. C. Talora 

-----Mensagem original-----
De: Colin Walters [mailto:walters@verbum.org] 
Enviada em: quarta-feira, 8 de dezembro de 2004 13:19
Para: Luis Fernando C. Talora
Cc: 'Luke Kenneth Casson Leighton'; (SELinux@tycho.nsa.gov)
Assunto: Re: RES: Problem with SELinux and Squid+Winbind+Samba

On Wed, 2004-12-08 at 08:36 -0200, Luis Fernando C. Talora wrote:
> That´s the problem: I have no idea of how to build policies for SELinux...
> Is there a way to remove SELinux features without reinstaling the OS 
> from the scratch?

You can disable SELinux enforcement just for Squid.
http://fedora.redhat.com/docs/selinux-faq-fc3/index.html#using-s-c-securityl
evel

> Or (maybe it´s better) could you please tell me where to find some 
> documentation about SELinux?

http://fedora.redhat.com/docs/selinux-faq-fc3/index.html
And there's a lot of other links from there.
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

Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA02751
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 08:20:20 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA17736
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 13:17:06 GMT
Received: from venere.mat.uniroma1.it ([151.100.50.3])
	by jazzswing.ncsc.mil  with ESMTP id NAA17732
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 13:17:05 GMT
Received: from inwind.it (archimede.mat.uniroma1.it [151.100.50.200])
	by venere.mat.uniroma1.it (8.9.1b+Sun/8.9.1) with ESMTP id OAA17439
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 14:17:59 +0100 (MET)
Message-ID: <3E5CBF1E.40001@inwind.it>
Date: Wed, 26 Feb 2003 14:20:30 +0100
From: Giorgio Zanin <giorgio.zanin@inwind.it>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: about the configuration language grammar
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i am having a look at the grammar of the SELinux configuration language. 
Productions for role declaration is the following:

role_type_def    :  ROLE identifier  TYPES names ';'

names    : identifier
               | nested_id_set
               | asterisk
               | tilde identifier
               | tilde nested_id_set
           
nested_id_set : '{' nested_id_list '}'

nested_id_list : nested_id_element
                         | nested_id_list nested_id_element

nested_id_element : identifier
                                | nested_id_set

Actually it's different from the ones in the document  "Configuring the 
SELinux Policy" (*) :

role_decl -> ROLE identifier TYPES types  ';'

types -> set

set ->  *  | identifier |  {  identifier_list  }  |  ~  identifier |  
~   {  identifier_ list  }

The former grammar is more difficult but more powerful. The latter is 
more natural and it seems to me to be enough. Why is it possible to 
express something like

role admin types { me { you { him } } }

and what's the meaning?

I'm working on a tool for configuration analisys. Am I safe if I change 
the grammar as in (*)?

Thanks

Giorgio


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

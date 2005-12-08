Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jB89nwMA007902
	for <selinux@tycho.nsa.gov>; Thu, 8 Dec 2005 04:49:59 -0500 (EST)
Received: from mx07.ms.so-net.ne.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jB89gOYY013327
	for <selinux@tycho.nsa.gov>; Thu, 8 Dec 2005 09:42:25 GMT
Received: from papa.intrajp-yokosuka.co.jp (pdd5cb4.ykhmac00.ap.so-net.ne.jp [218.221.92.180])
	by mx07.ms.so-net.ne.jp  with SMTP id jB89hACG022360
	for <selinux@tycho.nsa.gov>; Thu, 8 Dec 2005 18:43:10 +0900 (JST)
Date: Thu, 8 Dec 2005 18:47:31 +0900
From: shintarou_fujiwara <shin216@xf7.so-net.ne.jp>
To: selinux@tycho.nsa.gov
Subject: small c++ program which allows denied log (segate)
Message-Id: <20051208184731.49a799ca.shin216@xf7.so-net.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
This is Shintarou from Japan again.

This time I've written down on c++.
Several people in JSELUG advised me how to write on c++.
c++ has a library called BOOST and
with REGEX, you can use regular expression.
Please compile with -lboost_regex .
It's faster than script.

Hope seeing you people at symposium.

Thanks.


/*************
segate written by shintarou fujiwara
**************/
#include <iostream>
#include <fstream>
#include <string.h>
#include <vector>
#include <algorithm>
#include <boost/regex.hpp>
using namespace std;
using namespace boost;

int main()
{
	#define MAX_LOG 8460
	const char* filename="/var/log/audit/audit.log";
	const char* filename_new="./segate_audit_denied.log";
	
	ifstream is;
	is.open(filename);
	if(is)
	{
		vector<string> v2;
		vector<string>::iterator p2, p2_end;

		ofstream os;
		os.open(filename_new);
		if(os)
		{
			char buffer[MAX_LOG];
			const char* words="denied";
			vector<string> v;
			vector<string>::iterator p, p_end;
   
	 		while(is.getline(buffer, sizeof buffer))
			{
				if(strstr(buffer,words)){
					os << buffer << endl;
					v.push_back(buffer);
				}
				if(!os)
					break;
			}
			os.close();

			const char* den = "denied";
			const char* dom = "r:([^[:space:]]*)([:space:])?";
			const char* res = "object_r([^[:space:]]*)([:space:])?";
			const char* objc = "tclass(.*)";
			const char* acc = "\\{(.*)\\}";
			regex denied_exp(den);
			regex domain_exp(dom);
			regex resource_exp(res);
			regex object_class_exp(objc);
			regex access_vector_exp(acc);

			string policy_selinux = "";
			string allow_pre = "allow";
			string blank_w = " ";
			string colon = ":";
			string semicolon = ";";
			string domain = "";
			string resource = "";
			string object_class = "";
			string access_vector = "";
			
			for(p=v.begin(); p<v.end();p++){
				string source_ready = *p;
				const char* source = source_ready.c_str();
				cmatch what;
				if(regex_search(source,what,denied_exp)){
					if(regex_search(source,what,domain_exp)){
						domain = what[0];
						domain = domain.substr(2);
					}
					if(regex_search(source,what,resource_exp)){
						resource = what[0];
						resource = resource.substr(9);
					}
					if(regex_search(source,what,object_class_exp)){
						object_class = what[0];
						object_class = object_class.substr(7);
					}
					if(regex_search(source,what,access_vector_exp)){
						access_vector = what[0];
					}
					policy_selinux = allow_pre + blank_w + 
						domain + blank_w + resource + colon + 
						object_class + blank_w + access_vector + semicolon;
					v2.push_back(policy_selinux);
				}
			}
			sort(v2.begin(),v2.end());
			p2_end = unique(v2.begin(),v2.end());
			for(p2=v2.begin();p2<p2_end;p2++){	
				cout << *p2 << endl;
			}	
		is.close();
		}
	}
	return 0;
}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
